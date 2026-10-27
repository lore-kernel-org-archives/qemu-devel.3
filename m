Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51747606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yUYhb+9p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLips-0003ex-E1; Tue, 27 Oct 2026 11:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLipV-0003di-NX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:11:13 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLipS-00011U-BY
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:11:11 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c498fa2f365so315731666b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793113867; cv=none;
 d=google.com; s=arc-20260327;
 b=RCHh4iQcyAcLeVoRLQ4V0bLBVQ9B/VDWay2KYrICGtWLDmmcYw3VQsD754op/4w2R0
 HtkxfIFXnWnIC9QLUt2hiu9x9h3eVSqq/IEN1EgYjrdJduHlAGcG4RVxxQgP+cgNLsn9
 3pPt5oJFxkfFOLDH79cAMMVRVgr9yvIBrkB18oaJmKO9raOWweDp2EpIjNFR8mG5Wlng
 a7C4rP3bxOsDfp/AeYGIhIFOiQnOBi1yIRaNwFNCU71uqmvM5RbvR89xlaFCKIPz08AQ
 J/TaVgPWmYpjviBKo9xFyaVLdcq9dw+8eSFvXRcCd8+MRA/EBnj7ksw3yIwvDZgwwdW6
 UpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fds9GDMUn83ZlV72S6fMtPsNs76zFy5TRTrEwZS5ZfY=;
 fh=zitqL0Y4bSg66gAz+Nl/+uVjtvbilBhTwkAfC21QsMs=;
 b=QIl6RPjDznHzlPjT4WNCsavrRkDR2kxwjCaG7P1sLWzyPrqkpLMMH610IHdhYcq2R/
 U5JgSBWPYk3edKBTqKqY+ci90TURHu0+VR995n6mlSrZEoF196BMTCAeyWoutsi6SLNI
 zj+UKlTRKqb4JKOfjnM8hnxfgGbT58TzvfuiaHqcGI+6Aa0vX5j6XhirmHlpitVS6afC
 s9tCWABb3cG3YXLqSLhi1wSKCNMYGuVMx0LbZAA0c9cGORWW075cE4Pd25Y36dbpVf84
 Sr8QCbz1bRJt0d3cQ2CFwZeyw94nZluq9AxdOZlD1GQf8A1iTdv7xIxEnmGoDzSdtmhG
 0lkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793113867; x=1793718667; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fds9GDMUn83ZlV72S6fMtPsNs76zFy5TRTrEwZS5ZfY=;
 b=yUYhb+9piHrqNQIOq/U2EYKYM5XGTan9WfPsGbDeHva5uexRBcD6BhTuZiJay7OkE1
 Ap7sxGEPhfUa2Lgf7iZge9M5w7sKgDtzTwo6DkSjVv24fJFa8QFph1Zi4RXxhF0cKgcf
 C3DPCTcJ+DGJfnS5M0ltaErD2+4zWzTovnqdr7Cb9vdCUbKYZgwRy8/YdbyREZHVbCky
 gbjNiplI6apDHMJ+9S/r3zSpG7OunWANtpqbj6755awkSshJyKNFCoaQl29eFVZ2nhnZ
 m0dIFVwtJbYqhTF2YslzWGmQTho7nPjHJ6hm1+50qMNhlFEPm32Gygf+hmDgEsbaiEKf
 T2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793113867; x=1793718667;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fds9GDMUn83ZlV72S6fMtPsNs76zFy5TRTrEwZS5ZfY=;
 b=ISX64cYoVRfCfEyWDGEnSXeOswi/clNtP4Anw+FAUpF/Lm7KMUQJJHOaoKdzfJxo4z
 uEAUw5l4a690p0UwVzP2LYyrhducSOYgMr4S2IqEHhaFVGyzbWxP3/lcb4trKnIwfCFU
 hEW3Z8LkOWfj9XeUxdVxShxU5j6AJ18vevjuv5KmUrvfpPmifCoICcrof2BKYLBxlxDS
 6C30jrLVr5DjsgMkDJdQLNpAWYJD8xRHciONTJNlz+5CUjee5aPmEN6R7rFxndsTIJm4
 zg3iS886VoXzjdk+teBhCh26XZc2gQo76wQt78YKfBQlwC7PGISnDf7QxM75eThozsPD
 t2og==
X-Forwarded-Encrypted: i=1;
 AKwUvBwR+Pyj5WiV+iy5m8prDdKdyobjagFzh1lGVCb0KhQuSzV+mAJe+X/JHAlt/Edym0eP71xMEWisyF2U@nongnu.org
X-Gm-Message-State: AFq9FYIB///InsMuyzRsO5GqUISVpbiwdRPh5Z1p0OJYf6P2OCwN5OjZ
 JQO1vNzjS3V8eeZWCGVS8CRrqTH/sHwHrL1nuNh1actW3lSJC73pFcpCz1Ri7xhwOvgDHemqbcw
 EHLZqkYIGRt5VB1fiFtvF6PnkOcnk98cVWwHaQ/xPEg==
X-Gm-Gg: AYBFou1gnbaPAQ1S1RQSM44ERs668b1AobWoSePPVlb37x6N6T2f9+kVTNE9latiQYK
 azG5Hx48rRBXJu/KLK+AIjjwXG0g6BguE5lNCB/sgAZ367//44+0tad4cYwBV9a6WFyXQdgTMsw
 nuTGwe8Lz7xbILjN94Fhv4XUof23EWmkRdsSJs12unt2w8DsrLlXraTFuE0h4zsdGDecNEGqNsw
 spoFKXCG5wFQ4b2NXEHtMnauxjdL2IMYGBEmNeejoYRzK+ZF0QEPU/viijrNxl9zABBTwXnq+Js
 AQ3eCctpLxeQDd5PeOtaC6RGXJW8LxVQ0+aRk/9h/dFMdOFr8eJNqJYItkbd6LAjF86zmm9QaYv
 Pxu5qRn5sAzxvEQuzHn8ueapX/ZQN+vOYXQBTwGyNQUhCWudgf1hvhSfOZHdc+qs6eZTaHM0nO1
 B7J2byagqBe/KxmBhS4lwA
X-Received: by 2002:a17:907:3fa5:b0:c29:5340:182e with SMTP id
 a640c23a62f3a-c46bdac64a2mr1116029866b.2.1793113867264; Tue, 27 Oct 2026
 08:11:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261006083445.30362-1-shentey@gmail.com>
 <2FD6FED6-EBED-47A4-9096-D4FDF2F17406@gmail.com>
 <735a348c-3eb4-4a9c-bc41-6d347d4330ec@oss.qualcomm.com>
In-Reply-To: <735a348c-3eb4-4a9c-bc41-6d347d4330ec@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2026 15:10:52 +0000
X-Gm-Features: AclHuK8vjiayc19tHooowV3NSNSc6rrFF8pq0wvXg--_cBIczOb-_GJydei8Q7U
Message-ID: <CAFEAcA-J8qFpD4yVwoH2tYaUUa1RyhY_Bdj=EppK908czPk1tA@mail.gmail.com>
Subject: Re: [PATCH v4 00/31] i.MX fixes and cleanup
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org, 
 Jason Wang <jasowangio@gmail.com>, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 14:21, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 27/10/26 12:22, Bernhard Beschow wrote:
> >
> >
> > Am 6. Oktober 2026 08:34:12 UTC schrieb Bernhard Beschow <shentey@gmail=
.com>:
> >> This series fixes various issues in i.MX device emulation, cleans up i=
.MX
> >>
> >> Kconfig handling, and improves some code. Functional console tests for=
 the
> >>
> >> remaining i.MX boards are added where images are publicly available, e=
xcept for
> >>
> >> imx6ul which is taken care of in a different series [1]. Fixes which a=
ppear safe
> >>
> >> for backporting are cc'd to qemu-stable.
>
>
> > Ping
> >
> > All patches reviewed. One may need improved commit message. Am I suppos=
ed to resubmit the series or will this be done inline?
>
> I'll take care of it, thanks for the ping ;)
>
> Peter: I'm queuing this series (simpler for both of us I think).

Thanks, that's great.

-- PMM

