Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A4606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hgimGb3X;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Jbx+Fdwe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIqN-00081E-Hq; Fri, 06 Nov 2026 07:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIqK-0007vo-RF
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:14:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIqI-0006lo-3e
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FHL9BPI0duql7LgDbQy1EojrDj8ZxdZGgxmglKyMMTQ=;
 b=hgimGb3XVQ89iZTTdNY+FVo9OIjq+diwnusHrc6r7UBTM3+xfB8Ju7CvnU4viMANwksr7g
 0A+aAWobZoIeoophttmY6txYoYNUkUlIcLuDYC1AtM8/2YzwHnglQ624YJhkUwxBuz87EY
 /AKnJAoXujSF1k5EyrX2CB5KYIGOZZQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-YMfGeXORNfy7m01suHcWlg-1; Fri, 06 Nov 2026 07:14:48 -0500
X-MC-Unique: YMfGeXORNfy7m01suHcWlg-1
X-Mimecast-MFC-AGG-ID: YMfGeXORNfy7m01suHcWlg_1793967287
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-49323e268aeso367432f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 04:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793967287; x=1794572087; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FHL9BPI0duql7LgDbQy1EojrDj8ZxdZGgxmglKyMMTQ=;
 b=Jbx+FdweagNHx3dDWralvmBH+MKnrgmasEU1EtUGJ5HoUlpymARRCd4GcWXP3g1KKw
 N6Z1iXvoTNioOKLwK85IBPw8TZO8ZGCpBWuLIIwnuk6/Km5hL3vCfZ27aleUX9OuxcM+
 GJ7ZtmdLaGuVoH/31EZP2UIKnecBWHznUaH3ouuvJw2k+i54EOAFVmVnWw04t0Y9G5NP
 +aePYUFY7Y+B/zlyUVKZ/i0hmyOuAF3EkqVqDGGsGQkjB2sdN6K2VAgzPMeOQKytuOvr
 TIt5ThQYcTn5aMgmRWamZe0VNFz9Xus+5BgPc4JWpKa14S5x5NnMfdjZuDbx+aSGbLRW
 tGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793967287; x=1794572087;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FHL9BPI0duql7LgDbQy1EojrDj8ZxdZGgxmglKyMMTQ=;
 b=Tqmc9yj+9iEy/595vT/HgWNSfAp/oWQKqkfIqPsdCrUMVKZ/RUn76UQiechb0dUrEy
 nIaTOdA4zvjiN59cBkACwocZEGWY+v+X6pMu0TKxxU+Ok/4v+fV6Q2CfHQDWOZBZt8Wg
 O2RV5qHIxlU2HAh2630OOKmyjhfYnvpAlsD3O4tLPgSPHuWjQT6DXd45rnnnwiLQTJj6
 HLANMQkWb0d2E9vJfmj76KgnaZcyM4uQVnV2EaJ7+tOoweGzWR9/1J9DzhcwYz7y3glT
 Aix6eEWWPl9BPou+/hT+tPat93NZv4OXeUekO+iSiMXY1vVHtY09epZ8WRH9QInqbpJK
 ow7A==
X-Forwarded-Encrypted: i=1;
 AL+hErENTUAjw67wtgyczQzkzdVa2V8qEsDXIxa+kcUZlKL4j8THWwJ9vwkePVDEPXaY/8giVoCSuEnDmKeV@nongnu.org
X-Gm-Message-State: APuU4Z9pwa1pdFHyTiLCfNBpjYWEBNSRr/JK34UkV6YiDiPHdDHLTkXe
 ycsek/BR5BkIumVJ+Tz+O8o5PKV0I37gprPZtH1RPLbcLvjY4z9AttzvOQQv2+k5X8kmzYSda2H
 i2h8oSrVMbAZrqo8iGqFB1AFbiuUaVG/sSrj4d5OcfOt0OGfdGbUoI2Qc
X-Gm-Gg: AYBFou3EL4LyWfbfx3+pB/WRhjPwZsK7ZpYgRfjxMPL8zVts90QnhWHQC/46SylCBs+
 W4a/r1pAxfxR1skiSgzVuFVUVEroK086dmyPTj1dbPzDvJ7XmqvxTkeHYXXUPRsPreFligUNeZQ
 Y7aCxHk8qgM8x3ZRE2o4p8dqxaQtjvibnyBlT4HdlQTYgYCpe7hFxnQa0xWtdsGlNNer16BHPHT
 ioqIpsbmG9g8lb6TuKG8YfJbkRb6XpOvC5EZL8tup12Kovmv3xahg4gztZ3RRnj+XZPWthVfPF4
 2Vw3dU2TS91bC7x52bWXBZgcVk5uimd9LuBYT/81hvvR2koslaiOXJf0cTYsMjOoEbytFKCPRW6
 y6O26fH5PJGLf4CVOvrqH+iwGXXr7vbboIJ5MTFb/wcgpc5/A6NR0ab4WgVR5tKI1D9GuQ5LUo3
 TGxdpGFW3PYg==
X-Received: by 2002:adf:e186:0:b0:48e:60a7:e0bd with SMTP id
 ffacd0b85a97d-492792c2d8dmr5009205f8f.17.1793967286680; 
 Fri, 06 Nov 2026 04:14:46 -0800 (PST)
X-Received: by 2002:adf:e186:0:b0:48e:60a7:e0bd with SMTP id
 ffacd0b85a97d-492792c2d8dmr5009173f8f.17.1793967286352; 
 Fri, 06 Nov 2026 04:14:46 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6162sm3331004f8f.47.2026.11.06.04.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 04:14:45 -0800 (PST)
Message-ID: <38fdc56d-c380-4a3f-8a95-d12ddc1a9901@redhat.com>
Date: Fri, 6 Nov 2026 13:14:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/28] hw/watchdog: mark some watchdog devices as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-10-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-10-berrange@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> The ib700, i6300esb, gwdt, spapr and diag288 watchdog devices are marked
> as secure since they have traditionally been, or are intended to be,
> used in virtualization use cases on x86, arm, ppc and s390x architectures
> respectively. Other watchdogs are primarily for emulation.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com> #diag288
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/watchdog/sbsa_gwdt.c      | 1 +
>   hw/watchdog/spapr_watchdog.c | 1 +
>   hw/watchdog/wdt_diag288.c    | 1 +
>   hw/watchdog/wdt_i6300esb.c   | 1 +
>   hw/watchdog/wdt_ib700.c      | 1 +
>   5 files changed, 5 insertions(+)
Reviewed-by: Thomas Huth <thuth@redhat.com>


