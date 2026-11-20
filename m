Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35FB606C0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UwjrFGbe;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=S75NP9M0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUVT2-00086i-WF; Fri, 20 Nov 2026 15:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xUVSy-00085P-9W
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:44:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xUVSu-0000GM-8L
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795207450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PZxmtv74tpxvjKLd94BhgK799m2u8GX8OrKwlWaj6GM=;
 b=UwjrFGbeDxokcq8HE/zXg8DKHCLVPDsMt1NDJKK/f/sijahm9Pn9lruDM5F6DW1S1svG7R
 BQF9mF9u264Ib4qhnK0Gm+r0A3Gcqz9Ld4039nLz29Gh9O6+R/JJElp0vK8L7nap1XMp96
 n8TwpoAsyJGnJI88jorpMiRiQSvsaqM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-cP3hnBmuPIqk449T6_9PBQ-1; Fri, 20 Nov 2026 20:44:06 +0000
X-MC-Unique: cP3hnBmuPIqk449T6_9PBQ-1
X-Mimecast-MFC-AGG-ID: cP3hnBmuPIqk449T6_9PBQ_1795207445
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-490d2ac331bso1032695f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795207445; x=1795812245; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PZxmtv74tpxvjKLd94BhgK799m2u8GX8OrKwlWaj6GM=;
 b=S75NP9M0JP4VS88bLt2Tq/aexA3sJgynirpOFJVGevHydfM7wRgjFPRv9bijz64bop
 UpkFA47821CflV7ess5R0dTDRNCF7GCng4XwT/glk2jxWgAK1lTn2d02+dWysx/5Bo/I
 uodlRGoAYQLzY3UoXd00XoLBakernHdpEeV4Md+IF8UUmKqL1Xv/w9UOvFftQkWo2JyG
 WekyFxVpOiNhpWQYJkF96JBviDfMDjZedZtctfWtdxFlcbp59n5ZgdUcLRDZBXqGKWNU
 UrbE43Pf11MaAtcGGS8Z+xXQlP68jlnyqgx8FlbM8O9jDXxGg44yCsRbHtBdPQvVeGlp
 k6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795207445; x=1795812245;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PZxmtv74tpxvjKLd94BhgK799m2u8GX8OrKwlWaj6GM=;
 b=wvqtk1tKhMzP7vk9Y+OFZ4lomrM/zz1BNDz0xBTzNDSdLyQC/1nG0Q6rptRbm9gLip
 UY6LH7L4HoW+kCgDthu139wrqCCGjNGkbWb8YTvfqX8qOA8Fa+HuQVHIO68v93EiXWxJ
 IFed6d3TltcH/VbYl7DOBBBX2FaaDdP0dMGdrzas08M2OBBiqBvYlCe4pY+aXryXXXPI
 NlhzmACNWl2RxR6A05jaPpIF4OXOHUIfhOkfSm4MLRBx6eFcGxJrpxux+gF26NFimmsD
 fgmSMXc7M7fH++8kVjTlWiP+pQgBDm3Tu+4gqdUDVxDcc7xTT9wRJ/sdB9QQnrPks6Cx
 4DOA==
X-Forwarded-Encrypted: i=1;
 AL+hErHk+mMs6Jl3Z7vgyJaeZc8hDrYRYmACwtnm9QCV+EY7yjW0+nvIJFId8uHc2aKYWACmDJWYDUziAVlX@nongnu.org
X-Gm-Message-State: APuU4Z8NgKKGBoJDLQvz4jHaA6hI5l+vl8V+jRKB9jzZn1uGwtF8qfD9
 NwE2vH87e7PWO3ED251oS6ZgkkbofnbXhZyWoomFBRj5qEV+VP2JKWyw+3aOTOHbjVpP89D1j6e
 pfE07BnPlf59e/mf9D5ec8k5LIAQCduYFIWUkNxGvGLzwCNRo1EG7u8nt
X-Gm-Gg: AZFdTZfcAdH6s2STiWFdip1lrbRCV0pRPfEIMUEYI9yNH3ZozKmtExF8ESBYGWOYnLT
 GbZxeiN0IwnBEUu5xtPFoK6XZPc6vDjb/59kQNH+7QS0dHXcnzXJ1YKeVXNNyguUSn6mMMuMcBP
 ByttsW2/11SLiHs1WVOEcLxnkym89kg6Dq79iFMbpDY22KzDu3RCo1kueOKzg1x5HP+bAOJiXAZ
 SHKxmCpYggc+OdhvfsnlkIAvkEUat/dTCI/mrcaz47gYfiXMHJcUebO6rJlKnzdxp0VHaHL5nJx
 ZW39fAi1NCZBZryd3mNNEmNYBQRs/IujaAZeE4D6v9iA27ZRRcf52W9R6fHBNftZdSUixlW9IS/
 AlzO4eWivFFxGsrerLj1KWTyFpPLQpoqO5ChsNDOnriny
X-Received: by 2002:a05:6000:490b:b0:491:8462:20be with SMTP id
 ffacd0b85a97d-4abb1baaad9mr8942420f8f.12.1795207444948; 
 Fri, 20 Nov 2026 12:44:04 -0800 (PST)
X-Received: by 2002:a05:6000:490b:b0:491:8462:20be with SMTP id
 ffacd0b85a97d-4abb1baaad9mr8942396f8f.12.1795207444652; 
 Fri, 20 Nov 2026 12:44:04 -0800 (PST)
Received: from [192.168.0.9] ([47.65.243.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf685asm7062925f8f.20.2026.11.20.12.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 12:44:03 -0800 (PST)
Message-ID: <e3e73c68-7129-4371-aeae-c68eeeef08b8@redhat.com>
Date: Fri, 20 Nov 2026 21:44:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] tests/functional: update URL to rs6000 firmware
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Eric Farman <farman@linux.ibm.com>
References: <20261120121458.3723625-1-berrange@redhat.com>
 <20261120121458.3723625-4-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261120121458.3723625-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 20.11.26 um 13:14 schrieb Daniel P. Berrangé:
> The current mirror URL is throwing permission denied errors,
> so switch to an alternate site discoverd via Google.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/ppc/test_40p.py | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/functional/ppc/test_40p.py b/tests/functional/ppc/test_40p.py
> index 4c1c9bad6ec..084fe4c4e54 100755
> --- a/tests/functional/ppc/test_40p.py
> +++ b/tests/functional/ppc/test_40p.py
> @@ -17,8 +17,7 @@ class IbmPrep40pMachine(QemuSystemTest):
>       timeout = 60
>   
>       ASSET_BIOS = Asset(
> -        ('http://ftpmirror.your.org/pub/misc/'
> -         'ftp.software.ibm.com/rs6000/firmware/'
> +        ('https://public.dhe.ibm.com/eserver/pseries/firmware/'
>            '7020-40p/P12H0456.IMG'),
>           'd957f79c73f760d1455d2286fcd901ed6d06167320eb73511b478a939be25b3f')
>       ASSET_NETBSD40 = Asset(

Tested-by: Thomas Huth <thuth@redhat.com>


