Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AECC79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qMG-0002H3-VS; Tue, 08 Sep 2026 03:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3qMF-0002GQ-N6
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:35:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3qME-0000KJ-4g
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:35:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LfP71477274
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 07:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=ApVK2K6CK+SDMLvCTUfJLG00IBBZ+ndDHv1jcOYX8sk=; b=Z0
 cj6FuHgXyy42eFWYz4bqn7GEqDdiiTXQnOWME0ic11OMdnOeUOfb5wZke+CAqaLR
 TDC2GAu9v1rkL1Cp0TYbmd2r5dGloBKASXsYOllNmFWUBVa8DS3UhyudL4HscjcP
 FvCVYydz60I6e05ELI/xpK+EGvMlHZkzY4JyggxABtCNNe6NeWYXjt9bdFB6/H32
 IZ9Ho569jkbiuQEvVrm/CxC0iamYalUaBF+jltlGgp3Qf7+TcbQoTLVSI9xjGUNY
 4XtVhQu8t2gEeCvHNpSl64WKEB3cUf3mroinz7nipmRVnXrAIWaYweeFbev2S3t7
 RWR3GojiE7FExtvN4KGA==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjatjgsdg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:35:04 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66e509682ccso5565629d50.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 00:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788852904; cv=none;
 d=google.com; s=arc-20260327;
 b=klljyN8Emmgwr5JxM2H0k9BN7AGLxhIdEV9WgNozLwpb3yqK/bEWE8k9mP/qgIAtBn
 8UvPfhXXjtSnfjKZ9LGl2FdmymPkECRfzWPRDcT5HVrMTIwOZy6hdIiI/KlMo6bZdG1D
 CHA5g3CNr9e8TJRQB+gUvsMx3AB+OX8UXbBLaBfAf4cbaapvl926ksg1zWUiQALMqrl5
 lbX3jP+7IkyIecAK168aezopCzCFpIfySHZnvMPipyh9dp+0XbmIeBWOqsRmk5XMRQf+
 TRzIl8l3eKL07Zhz2G8894Oq3pYpSvuyUSPfV4HrJz9rK8clHearUf2JR6TpimZtg9Zi
 1sFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=ApVK2K6CK+SDMLvCTUfJLG00IBBZ+ndDHv1jcOYX8sk=;
 fh=wGCFoFUcW839KdtXS3Bzt9WYZWIaOCR17c6jvYHCqnI=;
 b=lCYl8AAToF1G64N1a+0wtoh/8LkW0Q2U9KqJmK0yhz1Aym3BATxI6zvUgv30fB8oGg
 OnOe4q0E9Sa61jsS3GRV7xRKRyO/GVlZVjvvvjPKa3GJ9bpgPs4yDuCTxdkm0StdkTgM
 1jnACg1tJ9a/krTo7kkilfGHys3e1ewHmWOYuEsLuakoyct3rehnEQun6oXeXHZvBxPT
 f+sVjHDEovLwJMqonv1qRUjwARAlBo5KFCKwHz8kpgna5+xK2gsIsF/4MQ8J8pWLn2SB
 lV/4I+fLTyi/6izV2pnUmOwEZ4rYGvolpKso2Ya+sSP46t+v8r6+UTEAKERRi0e3D6Bc
 wcZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788852904; x=1789457704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ApVK2K6CK+SDMLvCTUfJLG00IBBZ+ndDHv1jcOYX8sk=;
 b=Sob9f9mn6HDpbKG/NEOn521BWc/qBgL5RAgoga+HjD6KRj0Y7AHshewtEY8HZldJqw
 C+zPWyAh0SK1KyDQpDGpulBQwbjA8wTOl2X2jpKbCTquECJASUojCOeGSQDgkLgnfyBf
 10PRUMDYiZtiOWHPX0yEE5kwoB2OuEA4cmViFeCCTqW9Jsvz6WQ8uzAd75eQh0V6Rvbj
 ySyAVC3JHZ/fqEEUsGBus/3abWFNCbRy1MUftZH3jqVfsMZYUpQlQ1UGv/1Yf3OVxGFI
 ydhg27NCcEfduPgCTMm3VKGlTXrAOcnIoBZddepHrnVueDqQJKSVmmKMrQ7sqtHRlSBq
 VnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788852904; x=1789457704;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ApVK2K6CK+SDMLvCTUfJLG00IBBZ+ndDHv1jcOYX8sk=;
 b=mQxtrtRyxsJLLPZl+snhBK8nyLYJe8ZTdXXq/Tmo8xsENS0P4M0agcvPHIB0xBztq0
 JW9Tr2aOdW1weHEGbrEILi8ev1t77N439Dp7MXQ22ZOCcX0MmjQcZRW7yIts8/fu9iqO
 P/OUEY0gizZ+Kf3F0iufe+ZBuQEOVHZtHYqDqZhNIC52d+m0hqh6GhP/0kH1xS8uJOo/
 OWL/eQuQAt6zN82AhiDoJCO6m4ypa+3kB7m9dh4Cl5BsfhZLBR4m9t1+LI7v2FmVkhnr
 agvtMgvAE6Fg7L91t8WMu9SkEBI3B5jogrtbWsL74M5VIbDV7YZXRXCslUSzdKcxc6XH
 Gf5w==
X-Gm-Message-State: AFuF++kkqCKA/8glQ6WuklKej0pFRmz5prJmj7AHVkBjnOsjBNgtEBOn
 n42bqFYx2nZRV2x97Pbu2dhObW81unTTbchfEmTzhhcXiR81UJlIgyTm4d1ftfpV2MpLXUs/l9O
 pc0RVWpHAbqHdbycNc6BGRgcDirW5gv8tJplkjxAQY+cLJ0zCnS8xfmWKC4dmJtXabwrNzIVmrm
 /Ido+OA09+lUcsiI56jF0p/2+q+4vO7WGw
X-Gm-Gg: AYBFou0wSJGcD+JjcZF7r6680wIvnfFoPzz2ikA/mVufV+gz+lHpPlZJF2ogIaPCZcp
 abQlTsMzJ5i+qIyRkdZNMfoYEfD7JdoccaOZ8OQNZtf7EQKPXfPuakaSCRAV61dEpx/rELReAlB
 IGxSWp4Hlq9SO+prOrEyWdidKmrs2f4zoWUOydbXqMU48BauPTS5DSuZCMvok=
X-Received: by 2002:a05:690e:d88:b0:66e:51e0:f6a4 with SMTP id
 956f58d0204a3-66fc1be6e2bmr6563036d50.42.1788852903701; 
 Tue, 08 Sep 2026 00:35:03 -0700 (PDT)
X-Received: by 2002:a05:690e:d88:b0:66e:51e0:f6a4 with SMTP id
 956f58d0204a3-66fc1be6e2bmr6563027d50.42.1788852903201; Tue, 08 Sep 2026
 00:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260904195610.964829-5-daniel.barboza@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 13:04:52 +0530
X-Gm-Features: AcwNN1Xkaokp33i3BNbjSLIGhNWxOGSoEpBXtV08Fk-jM1dydhYceZHYhOr6FgI
Message-ID: <CAB19ukGG7=FUWbuBj8fnYEz8d3ze6gg-yVCccdO0Dj-Zg77HuQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] tests/functional/riscv64: add riscv-server-ref
 tests
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, andrew.jones@oss.qualcomm.com,
 leif.lindholm@oss.qualcomm.com, Chao Liu <chao.liu.zevorn@gmail.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3NiBTYWx0ZWRfXxst2Y+DtP8SB
 5FfmAaIqsvoduTjN8vcTjANpG/GHTAajYvMSspwTIUs7VKKWHFLWACoJpyneMrBDaunSLhSOkZd
 cjZ4Z1H3hsyFKxZmiCDkohY+Fy4qB8c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3NiBTYWx0ZWRfX21rZHELKh1nk
 uXPUkhGHHLSjFIX20LOFdgIt8sMtWjucs4S1U/cJs5AVWPVJNapiuyW5+ZUStCkjbFxAlZu/Vo5
 gVNs9uyDDKFcW8hFXUefxOMBhTMuW71RwiQM+nva24Av8z9RkmXKqsorWS/HYbYmsxKHDKY4e86
 v8I3qmpIHfcndm3ZioiPzt7ulppSe6EGT2L91o+4If5r5u916z2p2MTvMucpDHqBJNOMHdPc8p8
 xaGSsBfVwx0ZstB25WbB6Shb1hl6R6ADRw0VTis6BNls8WCFUibsTrux/AigV6A818mR6Wbhbez
 /5XwxXBnvOGGdMRPBSBeM5kks7Vfmjv8W2W/q93n2thUH+nGopfqSzWQoQ/AqPFpvtcigBvE5Y5
 NUn/MJVFUeascYTFVvjs0tpnV6gAmKqzfsEmNEqW0wh3g2kn78/Ge/+s17kkqZ31+ZCmd0+uiAk
 ePL1rEZMN6B2Nhb9JNA==
X-Proofpoint-ORIG-GUID: 3VJmYYFjVvewnhm-EjoNB_sim_tMWgGx
X-Authority-Analysis: v=2.4 cv=QrduG1yd c=1 sm=1 tr=0 ts=6a9fbaa8 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=69EAbJreAAAA:8
 a=JF9118EUAAAA:8 a=vQIqPbW8F-S7p7p2BZUA:9 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: 3VJmYYFjVvewnhm-EjoNB_sim_tMWgGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: sunilvl@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 5, 2026 at 1:27=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Add tests for the recently added riscv-server-ref machine:
>
> - a new test_opensbi.py test.  The idea is to have a quick test that can
> catch trivial regressions that would prevent OpenSBI to finish;
> - a new Linux boot "thorough" test that will boot the machine up to the
> buildroot prompt.
> - a TPM specific selftest for the riscv-server-ref board.  The test
> will be skipped if there's no 'swtpm' in the host.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  tests/functional/riscv64/meson.build        |  2 +
>  tests/functional/riscv64/test_opensbi.py    |  4 +
>  tests/functional/riscv64/test_server_ref.py | 88 +++++++++++++++++++++
>  3 files changed, 94 insertions(+)
>  create mode 100755 tests/functional/riscv64/test_server_ref.py
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

