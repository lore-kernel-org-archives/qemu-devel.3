Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F578EB3622
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7AX-0004YM-1g; Mon, 02 Mar 2026 12:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx7AP-0004Xb-BI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:34:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx7AM-0002D0-2E
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772472883;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FlWky5MhbdLuEP+OjyOBwrSQvDd6/6/EGoLoT+mybGE=;
 b=LObuVxIKLoB+BJ401Cy2acRBLhNSdAIPIIB99HI5/NpC4PlJdOgFen0YLtoh6RxGxYla5D
 vNYk8AN/q7PP3FpEKsyUtJcI76wjNfCPPZyGYhiApG3dG2SoP99sKSu0m1pDQjcsFbxF4a
 dyGJyjwZoOeeilICxvKDcYrXLLMM+w8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-Bj1SKuMxOMuqtfeEWKPVcQ-1; Mon, 02 Mar 2026 12:34:42 -0500
X-MC-Unique: Bj1SKuMxOMuqtfeEWKPVcQ-1
X-Mimecast-MFC-AGG-ID: Bj1SKuMxOMuqtfeEWKPVcQ_1772472881
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48378df3469so32785055e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 09:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772472881; x=1773077681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlWky5MhbdLuEP+OjyOBwrSQvDd6/6/EGoLoT+mybGE=;
 b=H7GTHP7KRIuK2xiVv1Srfrz6787MW9nWgLQMUE15R9hnbIPa82tA+jiFhe4SfpEwHS
 3Qo6/waFo0NFMBgegmSS+aKdjqcmPMs576jkXz2g8jlabzeZOKQ4IgGz0TswHPjfsS6Z
 qpcXdWVBShDGwoqpDcpEB1+NNGlxFe19JT0Ooe8ap3PkG71oRYkBZPMD4tEA+I6sJRUm
 tub1I5L9hNTKKqTUSTuVyWRoJXH21r9fvpI7KhtZRLphsPgtfe8xETq0hkZAq6m5fZd+
 X75HCskdteaWaeRExCRDTAblwxthGbBd/fCtWY2DQLbB/Dpek9mnhtFCRz2XV+etGCq9
 d+2g==
X-Gm-Message-State: AOJu0YxXp2meuXv8w6JyHoXwveT6eTCTD2uX5sHv35XLSh0OtjQWPiZm
 4wK5FUCpZ2BQpDAT3ElkaEGx+XnXhbd2MM0QUXYp3rW502o8DmbAX2t3I0dnFW545Vg1YbSSCSU
 bwHpCbv9cJdZ+VNRg/r0ifF89WNtkC6ArK2JCMsEX6EihZ9XSQZOUXeOx
X-Gm-Gg: ATEYQzxy2udTv2RyRSeuT6RJlQkSQV39SffOG/zwkoLn+1ygBg/gNgZA91au+AcKesU
 E/8+pXYY/ZQROfGvvbdMl4TVyXRALkokdr8PpuAbmd5S65XBsJiFx88Ohc8d9f/h2ltuE/RQMox
 H0ufRaS9r09QRna3iq7KRI91DFIkvrDDZGp+cniG63OyJxa6wG++4C5OsyD5S6IEos9vl9EpT91
 9icMg5haUNbwZHLPAb2NWAcWN6DVhTX0i+0UtkvQFzO/VhaFNoVBsY+15+gtnFg7jrvSnj2VeE3
 AGr7w+PNnvlf9Hr8ca/Xvwm8Cd6XJ4sdGK35IAzb82lQGwGy2p5Wsg4IG47FnPKYOCvSNaitWfK
 DXFDRwB2Xx9oszMZ1rztWDUTyRuw2A+kixENE3ZzchGbuo0T15YNq1xXetij+GCxgB3Acxw==
X-Received: by 2002:a05:600c:4e15:b0:483:29f4:26b3 with SMTP id
 5b1f17b1804b1-483c9906a11mr242387725e9.1.1772472881156; 
 Mon, 02 Mar 2026 09:34:41 -0800 (PST)
X-Received: by 2002:a05:600c:4e15:b0:483:29f4:26b3 with SMTP id
 5b1f17b1804b1-483c9906a11mr242387165e9.1.1772472880700; 
 Mon, 02 Mar 2026 09:34:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750701sm443972155e9.11.2026.03.02.09.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:34:40 -0800 (PST)
Message-ID: <3dd493e0-4788-4b91-9c2c-565938561bc3@redhat.com>
Date: Mon, 2 Mar 2026 18:34:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 13/31] hw/arm/smmu-common: Add sec_sid field to TLB
 entries
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101640.2993566-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260221101640.2993566-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/21/26 11:16 AM, Tao Tang wrote:
> This is a non-functional preparation step that adds storage for
> resolved security state in SMMUTLBEntry.

Add the "why"in the commit description.
>
> Together with the earlier commits that added NSCFG handling and
> PTE NS/NSTable helpers, the plumbing is complete and we can now
> refactor the PTW flow to handle Secure state.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  include/hw/arm/smmu-common.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index bd88e599c77..b0a02e12fe6 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -91,6 +91,7 @@ typedef struct SMMUTLBEntry {
>      uint8_t level;
>      uint8_t granule;
>      IOMMUAccessFlags parent_perm;
> +    SMMUSecSID sec_sid;
>  } SMMUTLBEntry;
what does it need to be part of the actual entry and not only of the key?

Eric
>  
>  /* Stage-2 configuration. */


