Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F168EFCBDD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2287-0002Pa-JN; Mon, 16 Mar 2026 03:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w227y-0001yd-Df
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w227t-0007vT-Ql
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773645140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kDiiUfqeNMn5TuXn3Lk32n7+ok7Dv5xuAewCzH4n1Nw=;
 b=EPcGpd6xjQWVbDNtpAlR7e75n8BjlKCThNbDHnriWAL8l3dadrBZdMaz6vcX7WwQpOppHJ
 ZUondzRebOF1CDOL5VHSTq32Qb5YKjqXv9TGBvBAbUvqw6nTHsZ0P7Vm5DgbVzaQFO+fWv
 +cbR3Ztht9NZAbuzd72E2j+y/3OABCY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-9eIt-lbSMLGlLRz3pQvAdA-1; Mon, 16 Mar 2026 03:12:18 -0400
X-MC-Unique: 9eIt-lbSMLGlLRz3pQvAdA-1
X-Mimecast-MFC-AGG-ID: 9eIt-lbSMLGlLRz3pQvAdA_1773645138
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-485397788b3so38883215e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 00:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773645137; x=1774249937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kDiiUfqeNMn5TuXn3Lk32n7+ok7Dv5xuAewCzH4n1Nw=;
 b=YEhnyea5oepC9b1y01TZCpGrilbl6Jh+Xkf6BbISzXaaMPLQj8GL/VBPb1+c4ObqBh
 kGQMd8tuBU9pYH9iut8EZ1W/5jRCc1oMpjA2Ix6OEsciv7B/dxQ/DVdGmnwVs/MXhT3F
 ex/4yOPFM7Aqi37hXjdElRVgHJLxm+PpEbcvwBhvbzDbszwgJ1hniyRv23dHZxihu/0D
 pmR1w+A6B3SsU9eSALkLWUtfrUf/XgLah7qPIqeVW1KM6+9gpEEHuVnEYa77lBg/z03j
 S8SL/Pcm9vEtqmmOsv8qTyfA+cx5uhW7VwXRVRi3uunxBbmY/ICCNnxopfiaTn3x8aFA
 Kzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773645137; x=1774249937;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDiiUfqeNMn5TuXn3Lk32n7+ok7Dv5xuAewCzH4n1Nw=;
 b=Z26maPYrybzGTQYitjC5JWVrKaqbUhNfTPbPrtHGZvl4pSRjQgoQzTKDarBbLhj04f
 wTb2kFlHVw2RVHagnstuu+zvLZ2a0bmSb6Xv22wUVfqtSyqrDlHeqAPg3VOqcNEMRbqK
 Bt9aseKhmZ3EXtSGn1XXpKtr37FC5vlCI6kIZHhyi/dFqqJBma/C9LBRmAjMnhnJlAx3
 0vS+JDDAAsNi9pfVX9TwC3OQ/xtpgsdJNA0kbDtd0nORGT5DYmmRFWzwpMCtDnU+hc1B
 lsOgaPaqIaGWxY/9pOqmQAChdRn7OJQ973O+P20VK1yKNVKc1Ok3Sj8214MjqLh4LqZo
 b9FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJpS4LmRx0o2H0bgNdvVQpZNz/gMT20YE9HbzFjHC/+q80PvFrExykBur30wHKAVkv0YrG/mwVeAT7@nongnu.org
X-Gm-Message-State: AOJu0YzjsPu/IXVJhfHBbPx+5QOYLG1hEd/uiQluqLvHTysis9vhjHQ8
 jXQHtiNH6TFUxAgeAjaMRyES7FHR3Za5Mfv+BHw4MWqcL9UX3twCyvsjao5kDazyu/iJQlJtx0J
 aROi/XQbdVsVPz1+nRRoS9tg65HfFCk+uYNCQEpGxDag9ziWd3uyMn9yK
X-Gm-Gg: ATEYQzzbTZW0oCDtQV72dqs46rcu1uSqFaDa6DPDkxmJNkOgYS4fZDOC+yKty23krpm
 ifSK1ZOq2hogHF4+DMBdeFkoZ2Zg0omwsNHCYiOZu5oAWUqFg7/2z8JK9Z+9nPPy4tVwtSrDHVQ
 FwEWS7ePCuGdG8uBzRaTLve6MiAtUH+oyYnMz7YE3wc+/0/jjm/5eK4gqxUMHN8hYHaCZ2VRbSj
 jubLRnoZneV5+lBBnLQkLJ93+8XA63ZBiir23avL5y4C3N85y1OAVV6eeTKxzJhJt8J8RLUxQQ8
 Dth5cvi/SRFCTaWfayJa1Diw9MyjmgOztQfvbk1gDp2X1Mcx378BJAFYcu0XutueQsfnUARqVCq
 C286EwZOp3FvPvZ5T7clAdRBbNtH76GWUlwQtAvFh6JoPSkfwkTmSvzMIakdV
X-Received: by 2002:a05:600c:4f54:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-485566fd026mr196512255e9.19.1773645137469; 
 Mon, 16 Mar 2026 00:12:17 -0700 (PDT)
X-Received: by 2002:a05:600c:4f54:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-485566fd026mr196511895e9.19.1773645137068; 
 Mon, 16 Mar 2026 00:12:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20b899sm38914049f8f.23.2026.03.16.00.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 00:12:16 -0700 (PDT)
Message-ID: <052f7c5f-027f-4927-bc5f-b14a2fff2209@redhat.com>
Date: Mon, 16 Mar 2026 08:12:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: Add Kane Chen as reviewer for Aspeed
 machines
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, 'Andrew Jeffery' <andrew@codeconstruct.com.au>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260316070347.3079299-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260316070347.3079299-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/16/26 08:03, Jamin Lin wrote:
> Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6730cee490..7c2bbbec54 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1252,6 +1252,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>   R: Steven Lee <steven_lee@aspeedtech.com>
>   R: Troy Lee <leetroy@gmail.com>
>   R: Jamin Lin <jamin_lin@aspeedtech.com>
> +R: Kane Chen <kane_chen@aspeedtech.com>
>   R: Andrew Jeffery <andrew@codeconstruct.com.au>
>   R: Joel Stanley <joel@jms.id.au>
>   L: qemu-arm@nongnu.org

Welcome Kane !

Do we want to keep everyone on the reviewers list ?

Does anyone want to step back ?


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


