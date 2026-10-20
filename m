Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721D606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IcHyeei0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=F6E0qdrr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ4SS-0000Vb-OI; Tue, 20 Oct 2026 03:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJ4SN-0000Uk-Fi
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJ4SL-0005WY-UW
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792482020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yfOB6ibdSSo9EOp2bYE6nyGmSMzUGBC1BOhPeWlBt7g=;
 b=IcHyeei0lSg24p+ExxmSHegVddS8bNvAoRDZBEKys+Pz6Jym8XwTHupUwiF3UL63bAQY83
 kqskHGMaLnQGrDDGWNgy1km5gqswqejp+gz6SL+2+urPY30c4hMS/uNkOWADaIwJ0G2FeX
 6DbjluaKoAw9iwfo66ECAEQCpvwc/Ho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646--J4bJtbuMDCXlk7cE_uLzA-1; Tue, 20 Oct 2026 07:40:19 +0000
X-MC-Unique: -J4bJtbuMDCXlk7cE_uLzA-1
X-Mimecast-MFC-AGG-ID: -J4bJtbuMDCXlk7cE_uLzA_1792482018
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48dea677afcso297749f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792482018; x=1793086818; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yfOB6ibdSSo9EOp2bYE6nyGmSMzUGBC1BOhPeWlBt7g=;
 b=F6E0qdrrKYFo9OwDfa9ItckoKI82liKFqMinFn/VMIPcMwygUuj24n2y2z70gD4HtA
 M64n1n7IL0nJ0nzjYcjLMBnXeAhIT/zEwLliIH4e/H4ks9MZGmG8p/gJwzDKPaSQpbnV
 wmNu7/74dlgMBKZLuRyaraH7WNslVc9wQb4fQkAnywpLu5GMfK98lGPyvP9iwP3MGIHt
 w7MYABhu3ocKg3u5vEWdtM3XBbx90OuNjYLUTeQ8OzyfrZKTCACeVmDkeH3Kb52qu6fq
 RshxvM3Y0vFmqcKsHhVmg06kreWWDNblLBg0s1vcxyA3ebmiyzUpOcfhqia3MTdmi9kJ
 Ozww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792482018; x=1793086818;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yfOB6ibdSSo9EOp2bYE6nyGmSMzUGBC1BOhPeWlBt7g=;
 b=VshZG5jdtNTWGodmO5/u18Cb1fKztUC+MUmpgu853jWFRc5iVJy8KBIN6M97cV+5kS
 ObJqsQSUxuncCxs/57qYT1/mopU1oqG/rZVfTbJ3JTN1DS0YCY2kfJ6AUKFExsTTOoxC
 TwVC7wEeNq40srl6fobw8wpp71mxbK++bG1rtyLC2olwvuqYX/jwgQlQN/F/RrQP8nzE
 QiRskdSsEWcXLpY0XjFun+tK3FdCmJ3ATOjCHKPwI40Gbajist1lJamEcEtsc4vSWRHJ
 jPBF7ykSTy+adf11pVeiP6m7Xns1giqtlO8gAKBQP5yCqGiRykcOiRRoRsCNxykC4gue
 KcSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT6vYkz6psju4bvI94wgmNw3jz2skoU9A3CQHiIZ5cAmRUGnG+DGCJt6TpD7SpOYt+GzAokpXgBL1U@nongnu.org
X-Gm-Message-State: AFq9FYKtmdn5Ag2lpZl3arsXtefm8+VeRpZ/MM4vueLMU7UunHvghU/A
 E1GbBRibySsYWR6ekn+G2dRK/rBzd7dkA8DUlq+IJvPGrEoukXjIh+STXLyHDycOpD8qpwsBtYX
 4L8lZx9D3uzwRE8dCmqRegpk7NGa1lkHMk7pQvygqL/S1VvspIzWPG19Q
X-Gm-Gg: AYBFou0+YoOBPH2O7oIgH9n50+TxyBzgEc9lJfr//qN/zpxZYFDDO7D3kdfnOOWk5LU
 92ucxLJR7jPYz6EQ1KG41pnUm2ml3VBCezb7rRbGWCFOokJDKvdwGk67lHWY9H5MT4qeOdy94nX
 gxSW6unx6URP559fJgRhyN+yNnogLFLYgkFgGf8EA1BO7hvlkGqBRmHZ1cI88/EAMVYPgMN0G61
 4GfVnrecb3mWvWCve3HTgpaDUpfYt4PJh4K+WKvMcRHVrgF4p+PdpbS6EIegx5XhH7S08JVMKAY
 fzpjXbWD6UTmui12Yn8eStmOIDBv+EEGEnhmLRN+pHF97VRKkuX+OQ3GKitj7tUJdFTyqh+2
X-Received: by 2002:a5d:5d86:0:b0:48e:d40:a87c with SMTP id
 ffacd0b85a97d-48e1e7cc307mr3267198f8f.16.1792482018180; 
 Tue, 20 Oct 2026 00:40:18 -0700 (PDT)
X-Received: by 2002:a5d:5d86:0:b0:48e:d40:a87c with SMTP id
 ffacd0b85a97d-48e1e7cc307mr3267124f8f.16.1792482017679; 
 Tue, 20 Oct 2026 00:40:17 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8244e1sm4097987f8f.44.2026.10.20.00.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 00:40:17 -0700 (PDT)
Message-ID: <7b003f73-b025-4b62-a1fd-2276994ea919@redhat.com>
Date: Tue, 20 Oct 2026 09:40:14 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/19] tests/guest-debug: convert gdb_cmd to an array
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>, qemu-arm@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 John Snow <jsnow@redhat.com>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-9-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261019192704.3220373-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/2026 21.26, Alex Bennée wrote:
> Passing a plain string to subprocess involves making sure the escaping
> is correct so the underlying shell doesn't get confused. This can be
> tricky to track across multiple  processes. To simplify this build the
> command as an array and execute gdb directly without involving the
> shell.
> 
> We add a mini-helper to make the log output a bit more copy and paste
> friendly.
> 
> Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/guest-debug/run-test.py | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


