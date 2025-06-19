Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FFAC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 14:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSGRq-0006Hn-Rf; Thu, 19 Jun 2025 10:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1uSGRe-0006Fw-Ot
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 10:40:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1uSGRc-0004ya-3f
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 10:40:50 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8H8sr023689
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7egzB71KgEy6DGRuLUQB30VjVlUozKtUHQPa0vK6/jc=; b=Eym/o2RZ0ceaaGSF
 OHq+HWS4+FY0fSWoLjmA811sZi1sPsa62Njr/c9oagBEr9UBJEiM3v2+OLqqzJjq
 bSkpGvVwzCixhmxcsQpDxNMD8H8pMp5cARviIt9nPmIE6vzda28iZtQ5meI5/Xyx
 mn7hvMyFv+sz2zTFrXI7C2Ud3hR9dPYtugvBcHuBvOv2y/MtL5No2ii2NrAvC2Ob
 IVsMa97oAR1ibKMW4bHc13DCKJyF+NLhJDWtw0TFhxjyKC2OmtBD5Yi78hX2PQUp
 IO6YEYLbmeKoGNWoOFabnIut8UWG7H085vE10IJmIYdwxBpmo8SegvL589tH048u
 aolfEw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 479qp5xxt5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:40:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-234906c5e29so12513535ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 07:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750344044; x=1750948844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7egzB71KgEy6DGRuLUQB30VjVlUozKtUHQPa0vK6/jc=;
 b=BKF2+ELIFGa7BrRkLEsPOeAHuyuskGil346/mUDW6ocjZmNTvSizWBthJrlo7wOmWX
 nRSPOMhl3+hCQ5thWqtGdKjf/+5KsuGlctm3wqIihGmZzpc3xuXOfTGxWQINdjqIqmgz
 fWzFpUpX7s7siPeW5yy+y9Z5bHFYc4chA6EMHPujY/QxXu/z5sakYYYmYNgC3zZ2ITSd
 ZlJZl+TabYA6mSWeXhoyP0xrned+1MwYM1VbwbCpTm6y9wO/BKB96sWRx83idq7T8m5w
 /vpVTwhAnCSU+STyf/1lcdb5bnr8OuuP3BN4H2ed2juEic4f5yr7Aw8SU4AUfDNsCko1
 P2lA==
X-Gm-Message-State: AOJu0YyY6X0ZGYBuq16VHJP3z7Gx12f8i37NvZ8RDz1WTTiZSrX7DTP0
 e97dNhSFYhlYiJPpUg8+WrEEDeQT1gReuDJCFN0KFqZFa2ARNnkTBk694As/7CPpl4FDqWWvnhK
 aGVdPT8yjutLMnLPWlBk5PbGfWTsvzHNOw7tj+wSz9ylTyYtJ7yOUdqq9XWNGa+CYcHKSVWAcvA
 cTuqyrn0tMkUoqS8UXfFop/Ln+OWHTG6nO
X-Gm-Gg: ASbGnctqmky7uFe43CNKHutuj7PbOxyRtvMCsYxl5uLE69kQdZankDUfFn/ilFF07Nb
 O7enmE5UFSYbLpCR2HaZl+Rv5kXfyw7CxH53FwtWBjYkLLn8bcAzPcl0rntCU725IZAZbnVXa1V
 H/nnXHzopHPK8bOTS6omblA1qy8erN07qrOXkn
X-Received: by 2002:a17:902:ccc8:b0:234:eb6:a35d with SMTP id
 d9443c01a7336-2366b136680mr324320645ad.27.1750344044517; 
 Thu, 19 Jun 2025 07:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+0yJ7wpym4GJnfkKFiiyyrVWhI1JLeLtZHu0O6sgSlZnHvRcNihFaImcEjyXw9FX17XVv8WiwQGyETI/8EiQ=
X-Received: by 2002:a17:902:ccc8:b0:234:eb6:a35d with SMTP id
 d9443c01a7336-2366b136680mr324320115ad.27.1750344044055; Thu, 19 Jun 2025
 07:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-21-philmd@linaro.org>
 <CAPMQPEJTTa4NiEvj9pmrubyn3dTB=13PW6scive=nfAGVtqMHw@mail.gmail.com>
In-Reply-To: <CAPMQPEJTTa4NiEvj9pmrubyn3dTB=13PW6scive=nfAGVtqMHw@mail.gmail.com>
From: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Date: Thu, 19 Jun 2025 15:40:32 +0100
X-Gm-Features: AX0GCFtwtN7llzon1ANpJ2JjGfFA9AlqnSbO4UehnDWWNXuYEFiuEUKdYbwNL2I
Message-ID: <CAD=n3R2S17nYoikdvVwOW=aF4wW=Pk7_86H3sN8R7v20HVArTg@mail.gmail.com>
Subject: Re: [PATCH 20/20] tests/functional/sbsa-ref: Move where machine type
 is set
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: iNq6SA2fPbj-35LSkN6q7IoDvJW8d8sd
X-Proofpoint-ORIG-GUID: iNq6SA2fPbj-35LSkN6q7IoDvJW8d8sd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEyMiBTYWx0ZWRfX1UFIywYRl9y5
 xEQ+shghAfazvhmeMJ0Gi1UeU9NY499kpJBd/LVkWtqCFX6xcH73UMCitupaeQpAJcLx6n9p81H
 dyeI5UbXcgH/fuNC2OHelZENnK05KNME/VRJRjLi0TWZNsyJ9iQ/n7g4GgQPoxV1Hsiq6C7Lzlk
 vZSh5aG1to85gbKaURXA4bd3afrxuGPIRAamTiUtGREIzaQnyV8QKoL6JoFVvBu7zOzbOX/AxL0
 qee0cQuYG4Jpz9cXbcc8QT51TuxEWQJKmFXXvjAs4tuR1oohWGgsWpi3Vm8UYrC+BgV+psSOpQB
 NWUxRozF6dKRB7r4H32rjBKSdjQIC8ywxpzeEYBNJ0Nv+DuyHJYcIurzhlkQXmTV4vG4q99mvge
 akiQ7SzTA04aHLOXTREqAt6a1ToOyLCB8AlxbBjzJWinVgYiRrEy5M5owLC4VBpU0tJS92bm
X-Authority-Analysis: v=2.4 cv=fMc53Yae c=1 sm=1 tr=0 ts=6854216d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=655RdkjLQMz9J5miF_YA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=818 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506190122
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=leif.lindholm@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 19 Jun 2025 at 14:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On Thu, 19 Jun 2025 at 15:15, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > fetch_firmware() is only about fetching firmware.
> > Set the machine type in test_sbsaref_edk2_firmware().
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >  tests/functional/test_aarch64_sbsaref.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functiona=
l/test_aarch64_sbsaref.py
> > index e6a55aecfac..5536ec622e6 100755
> > --- a/tests/functional/test_aarch64_sbsaref.py
> > +++ b/tests/functional/test_aarch64_sbsaref.py
> > @@ -40,7 +40,6 @@ def fetch_firmware(test):
> >          with open(path, "ab+") as fd:
> >              fd.truncate(256 << 20)  # Expand volumes to 256MiB
> >
> > -    test.set_machine('sbsa-ref')
> >      test.vm.set_console()
> >      test.vm.add_args(
> >          "-drive", f"if=3Dpflash,file=3D{fs0_path},format=3Draw",
> > @@ -70,6 +69,7 @@ def test_sbsaref_edk2_firmware(self):
> >
> >          fetch_firmware(self)
> >
> > +        self.set_machine('sbsa-ref')
> >          self.vm.add_args('-cpu', 'cortex-a57')
> >          self.vm.launch()
>
> Sorry, last patch, I forgot to squash:

With the squash:
Reviewed-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>

/
    Leif
> -- >8 --
> diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py
> b/tests/functional/test_aarch64_sbsaref_alpine.py
> index 6108ec65a54..98762eedb67 100755
> --- a/tests/functional/test_aarch64_sbsaref_alpine.py
> +++ b/tests/functional/test_aarch64_sbsaref_alpine.py
> @@ -32,2 +32,3 @@ def boot_alpine_linux(self, cpu=3DNone):
>
> +        self.set_machine('sbsa-ref')
>          self.vm.set_console()
> diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py
> b/tests/functional/test_aarch64_sbsaref_freebsd.py
> index 26dfc5878bb..1c243d0d459 100755
> --- a/tests/functional/test_aarch64_sbsaref_freebsd.py
> +++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
> @@ -32,2 +32,3 @@ def boot_freebsd14(self, cpu=3DNone):
>
> +        self.set_machine('sbsa-ref')
>          self.vm.set_console()
> ---

