Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23580606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QoY0JOgt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxMn-0008Td-9r; Tue, 24 Nov 2026 15:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxMi-0008Ov-Qn
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:43:49 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxMf-0000UF-Qw
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:43:47 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67da564d9f2so6776097d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:43:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795553024; cv=none;
 d=google.com; s=arc-20260327;
 b=B0BQgxBrRzwCatbkpoCP0pRhiNU72ZfTXonWlhtr1yFsV4Edo6Sq6txhtB02mS3AyY
 HihxAP4LhdoU6/apNIXRaTjB779zFXwT8wqQpo7UlsLRL+K6Qa1BIFSraJN2YZNzlo7R
 FhxRiXAMeJCQ6CvpLrNWx+MPDafCRy+tYTJ8hipOYRScUNYkL8yFTZ/jH6OUwvQo5LsN
 Du72yoQVnpKATPFZXizduS69WXmm220Yppy/uEqEHq7cRPxLnhCR44htRgbJYvHnrIGI
 7wY3uurdeH5zU0YBnD+7D2mbm3QfIliUkk0XCdX14sjJYjonBCz7cT/X6b9Ap27u/6FG
 DSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d5nEQqfw//W26gz8hj9ftoo8J8vKZHZMhym2nnoSGfs=;
 fh=iwFg1LxsWRNZ4TVNHhNTnJl1wQs8oEV2+nhEaCW4Hxo=;
 b=NNT+hYYUKNOPyIKf/MrKcG561i/Y8/iJcH9/afkjdtOxl5SUPIqXg0jVH0hkFI2q7i
 99enumQGKzu3QDM3LXpvKoFMZ7KjWzeBH9Vd0npXf50GrGxdl9Ale/p4lpGrtH1QktGd
 pI5EtsvNucwom53/KeAKH8GD8S4RetMRunUxuhZeCDSKSBKaHynEzihvzIs0m6ozll94
 +jomyy1/LY9KXqqbguz4FY5nOWDGYQh3+B0MpuF62TFwpGytDAhzS/dDazfraP0Q8M13
 u9NnuaYcP0FlU1fVJ3sjbvlzXI1mntDU3aAo9OULKWXLlCfAVk4wg2IQBMS7CoYGfUtx
 3yCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795553024; x=1796157824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d5nEQqfw//W26gz8hj9ftoo8J8vKZHZMhym2nnoSGfs=;
 b=QoY0JOgtH4EOj2mY+nFutsWvpzh/SV9p3WVewBJZb4ZKRavVt6yXup0JutrL2ZO8Bb
 0SyBSSRcx/1mLUoGGgqc0k/xw5vKizypaWLsblZvz6t9Pk7Ffz5mJXvcNQDqEYHzsmOO
 tkaKVTCyYvKwdYLO6IQ+hyctvqdNgUDEMv3vPu3E3UW8G7QNdbw4snxWacVJ92aivme4
 S7+UbRpoQm4HeaZiJ8RqLZ3VrVUaKBoBa62D5eB9ntW8JMwOp8deE7POmGDfUq4SVJvD
 S5J7gwqV6YZRgJQayygDKryN+3C5jsrNGDWUpqG+xgsxDLBgRvcoVpiMpoEE1+rS9AtR
 aZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795553024; x=1796157824;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d5nEQqfw//W26gz8hj9ftoo8J8vKZHZMhym2nnoSGfs=;
 b=DxYzwnno3JbDbN8IfD9/MjKtNhHroIxqzzrUTXbcP+2/MvyKILBj8C1gZPH1sUzsd0
 Nf1ml8MlYRUB4ycQAh0ox8qLcOGEISP7kP201u74uybAjWltufu4RBVIbRAgiOCCoxuw
 qkKzjIe8jJW7T2czo76tNsK5b8qtXE97Wb89H7E7RXudkBR+e4sMWCapj7EUHWXM4GdL
 /hmzkel8KmHPw9E1OaOxjVBasmvhDZJei4HurFEPhSDTXchygCrAebSKsoh7xYD4MmUi
 Oz9425rW9pzKB5JLNC1cLQRGJiDKmIu3hAuVYg2Q37lENRsEVVZ4ywvlW1+VEzK3n4i3
 8Hkg==
X-Gm-Message-State: APuU4Z/7C0rSepN2vYUaNLYhA/Hi5SwLBt/Fe0fJqhTIfy9jed6Z5Wrx
 5o2uckEK5w2EwbL5Pe064wsBe9gjf0lM8XRKFq4bLHzc44IWQ1skAtNcdmVyQl2/yookAL/TdW0
 F5tT337ZX4Lsd8CIADr/vQfisc6IJh0cRImaHBeylPg==
X-Gm-Gg: AZFdTZdPCw4P3M86QHGiVk2iBD1Tivxc/KMKbLA1ayyXQDeIAHYKn9uMiVAwlnuEqug
 0sy4qWb8xOY3k6KYokP5Hj4Hg3HTAWcCEBzVMEpAWmPu+agwkrP61KKPmESNzwcUC+No1ftcbwf
 bNJ+NiB28g50pFtAh6pNmNtLPzdynIEtlp87K4orSPEsntzO7/6IpisKOCHX44aahG8afjlkpk1
 Rcrak/1OdPMeMTiFUVc/egagvdbjJA5cjdOFpeDCF9Z13Ckj+xZvteooZyESGcsIsv9vQbPC337
 iCxzbgM5Uw+G30wFRvXRpdial1foZAMBDAszmYEUeFHLvGUIWqjkHeHJNjF6MGJznsH84AgIppE
 WipsQcnPrp4ayiszYJyOJnQ90K5AQwxIcsgzABUrB2/AotGXihuEdumCnYYxy1fYGr/1nP2mFlj
 f53Hwi1bY7wd8D87uIk9d1
X-Received: by 2002:a05:690e:4005:b0:67d:c046:4f69 with SMTP id
 956f58d0204a3-67df43d0905mr6568907d50.34.1795553023930; Tue, 24 Nov 2026
 12:43:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124181209.71534-1-philmd@oss.qualcomm.com>
In-Reply-To: <20261124181209.71534-1-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 20:43:31 +0000
X-Gm-Features: Aa3M54pAyKYa4-UokPpw4RrgKb9BN0xPHZHKYMQx5pMJmZgfP5wYGjfUs7LxQGA
Message-ID: <CAFEAcA8U-WVZn04QhkFzr0a-iCmz7Ls2AOqGDPUsKSqaY3XrPA@mail.gmail.com>
Subject: Re: [PATCH] hw/block/pflash_cfi02: Return to read-array mode on reset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 18:12, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Reset left the ROM device in MMIO mode when reset in a command
> sequence, unlike pflash_cfi01. Use the read-array transition.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/block/pflash_cfi02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 4f72c438c0ca..8d130e14d1c1 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -958,7 +958,7 @@ static void pflash_cfi02_reset(DeviceState *dev)
>  {
>      PFlashCFI02 *pfl =3D PFLASH_CFI02(dev);
>
> -    pflash_reset_state_machine(pfl);
> +    pflash_mode_read_array(pfl);
>  }
>
>  static const Property pflash_cfi02_properties[] =3D {
> --
> 2.55.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

