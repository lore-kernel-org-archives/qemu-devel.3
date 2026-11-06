Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C34606A32D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E+z0Wq5h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMOt-0003w2-6a; Fri, 06 Nov 2026 11:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMOd-0003v1-C8
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:02:34 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMOa-00023b-S0
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:02:31 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b0dba37a7fso6772937b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 08:02:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793980944; cv=none;
 d=google.com; s=arc-20260327;
 b=lZd2uzRhZl2myNF+2FE1VrCBT6gga4BzKWp9b5iNpeARAWS0CljrKqNv6xGBKX28Qi
 L0pgaW4pclOpp3R2uIPKAm2klYnFBJOugcaTk+x6H0n5BJDLFB4TIzC/hXEjBl6xsxbH
 fJxtmqjCmHOK+D9P7wKLbZ4xFRxzRYklO/eWJhLnTDZWPgdCy7Vb4+GfmckKPBhsNUzD
 EXiWjEKHSbsHK5iNMaZtrqIWCW9+ii3010VHxWA3jH7GcbAEzpO1OHZjTPjlkAhPBzQR
 Qb1Z+1xSDTdtSHCaCtPtqe7DfMWLFz1g+JknWtti+iT0TFaS9PMvI9DCqApiTBrcjo4p
 Dq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kZCBSloje9XqtTEpv7EcNMvQtBKDJh6EPwCU600igOY=;
 fh=6uH3Ez3JRYvyspmRPRc6mDbAwCB5RenVYV5gYi8/nJ8=;
 b=PxFPgB+DcPowMoPJP+CxrbOP3NIib+SlTvrK4jWkk9U9Kw7+t01ZMS5jXxXvJi8unF
 AF4sdRqoArbrX4tg92Q8taDxDWCYXiW85a5+pHemV1muXwUakkwZw/VZxf/0/X3AFMqg
 O5gmykdmCfJXqxHQEw+XjSPN/7Xsi/lhYOd1s3Ly9YNE87C0hlnKJN75sGGSY9ljKCKj
 BP77em7e1gqXW3N7/8rBen3+SwgoDy6FQakUY1r+2+mPH3yhJarXmMwa1TgYPnhUU9hL
 gBhIsWcgBl+u0gc/a1a5Mv7G7UlPEvjUX9vaeFVxpBkr8tIrKlw5YxIVy9qeKNWjalyo
 hX9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793980944; x=1794585744; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kZCBSloje9XqtTEpv7EcNMvQtBKDJh6EPwCU600igOY=;
 b=E+z0Wq5hYM2dwqThCFuhhet7H0P2HbDdUsa8R1vkISm/vBdaWtoG8NZGn9T8/etvni
 aCBzlsDLSh1sCDATb3DwpSAFKoLu5bDaA0RjE6O5mTZFt96a2EfT1gkmXy62UXAhn295
 j7duoypqi0Ij4Oe70adLpXL0EpMggSshElEAb2uDWZQnSDKEqtynMhGNLlpg/kW1Uxkp
 iSMVmlhNOQ9f3Vtc1rnbD2rZf59UYql0IKpP+mDRI5d1FiRlYFEPbnv0Li6ulsTBMGoc
 XpBLL3v3dx1fU1iocbLXe4W+Lq015e5dSraRty6vGY/gADfTLikaM//bDawMYIRQJXBH
 lEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793980944; x=1794585744;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kZCBSloje9XqtTEpv7EcNMvQtBKDJh6EPwCU600igOY=;
 b=M02zev3KvFEHqwhJhmp2fjEL4CMDUGJefCWl+RlKWho0xrFPv1QDX9+MGKtglhml3Y
 WdApWOqJInY8JrzWzrh6olIHNh94fNZZI//0c4RQ3W/xdirUj5RC8FSjGEBL/Uc7MRBC
 h8UNkIfc54J6tMMDipi/5BQLDHnSbRmPPavVA18cmV12ohB/W/54ZHL0yyEQSYPevW0g
 JQJV2D3cr+/2AY183pqD33BYP33yBKC9bnkJo5JTpeIWcaWJ5vKcdIlRbq7mKIkkoamC
 Hm+6MQrBCizongoCsTTnt9lZSbr2WYJMxceo3Luj8ek45btgnRCE3iBMl8/0n0jO/0C4
 1tjw==
X-Gm-Message-State: APuU4Z83UEs/wB9Ks2xWPEJ8rwHqcOLKTyVOj32UNlpWcxzAop1+z5gj
 r3qvohiosxQn35DpepQc+jtOdXwB9TKxaj0M7zpfyckm53A7bJUqila3OJkztIkdPESRYCf/CNV
 u7hz0S5ZLgoS6bNSdRghsChzYlkmZ/TIAOB9SZbxTyw==
X-Gm-Gg: AYBFou0vQ7nEjPplHQ+nCFQs/22b/QuuMQ/K29/GaXmvrnI3++pYpJ3sglNXJQtXLV6
 m2tjveyBIEhQozF+QzATKnbFYuAI/PQR8OckOK+MmaQyE2RQ+H6MKfrmDWrzlAt+gRiOkoamPJ3
 UWeaCzXm9nRLMa0xgCU2aiVlOI26jYwWVbAvN2PABVpxWuZtG2vftwB5RxfvnseYbmLsO+p1qDj
 kapSW7p0qygU0kkTs3dsM+qywOUX63YwKk0wGzYW6E6tS7P+/rpmIgyNvjfiiyLApuFj/IFFT+1
 TiOmPupFif7cjAJVI9u7N7BsU1OMfLtXCkarh7mKGXzFlDMxLw0uTtfjP2IYvwW375TmSl4fsKy
 NHvV6WJ9DborJIYnCRfH2QApytSSZqrIuLKZBSWS8QkvmvXn30FcCKLBoG1fdqJzMDy93t4tfxE
 HIa8ZjSuFi49IKv00DxIXe
X-Received: by 2002:a05:690c:6605:b0:8b1:a3f3:7085 with SMTP id
 00721157ae682-8b3419c287dmr11732157b3.60.1793980944149; Fri, 06 Nov 2026
 08:02:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
 <20261105125203.40320-2-philmd@oss.qualcomm.com>
In-Reply-To: <20261105125203.40320-2-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 16:02:12 +0000
X-Gm-Features: AclHuK8uvR8xxkXdSiK1iaQiEfbrGMfyI7ASL-Ch-aBtNpd1c9eXgL8t4kEBjpQ
Message-ID: <CAFEAcA_kzBBUcyPEG3Cn8TnGqvqfOaq4_skEG+r1FXO0Q-n51g@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] tests/qtest: Use qemu_hexdump_to_buffer() in
 qtest_memwrite()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 12:53, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Replace sprintf("%02x) by equivalent qemu_hexdump_to_buffer()
> helper and silent when using Apple clang 17.0.0:
>
>   ../tests/qtest/libqtest.c:1522:9: warning: 'sprintf' is deprecated:
>     This function is provided for compatibility reasons only.
>     Due to security concerns inherent in the design of sprintf(3),
>     it is highly recommended that you use snprintf(3) instead.
>     [-Wdeprecated-declarations]
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

