Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D79C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6AZ3-0005ut-Ev; Mon, 14 Sep 2026 13:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6AZ1-0005uC-M6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:33:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6AZ0-0005Nc-5v
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:33:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0ZmK1025912
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sGqwfYFnnhIGpmP5STGGKrJ6Z6vQHlLNcOlMgCn5PgA=; b=QheA78iFtRsPr189
 YQq83yiMY6T/fvxw7QFhFTLdRLQvZL+pCfXoAmCn6eNw/mN2TWEgQk3rJz93kpFv
 IJ/jFYfychMyRjOvSUlXxnceJWf+c3rbOjl42sNIrrLk40Seax1S5l9aAWyCx3dU
 UDPAnt2E16xMvNOIs8767noJ5wWqLxrRob2ANFszBRq0bz43xDQHmkUtoKQysmYx
 6S9cWX3a+z+wK5IT8U2yLuf61a6VFJ/aj7UaYj8fT7VQ+KdwsQqW01GlDNs7l5SZ
 Eqx8E5zOq2apDw15tmkGTYWlMewCFO7kh1RVhtTCpOijmJH6zdftKqXEyJe7lSj9
 myZosQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdb5t92v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:33:48 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6b1abf73d1fso2150374eaf.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 10:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789407228; cv=none;
 d=google.com; s=arc-20260327;
 b=Yp5WSZYa9pOerRvtEDZ0dM9ExqcRDrhcpvW1kEfJj78r6Cyk3s5VZfFhk9qtFi45Sk
 SwbAEBNknxuMk1KpOuIeZk/LTwfjEccIvwV1Q76r0E+gT6Z6YAAvi7jvVZH1hBTCQG2b
 aeaSi9MeBiZXCOqbJOqIW++3hfjmdy2w06qztB/Cnlz6SVJnb3I2EIkFJlBrWdzaHEOV
 6ef6XtrzCb+guUGsTp4UiGiERlJbswarB0lUr3xh3bD75mXUnoZ1MNw+PNDw9eW4VZOl
 L5RgDgObiYn9cLg0OG6Uyfwhu5+pZ/y4Hb2/mBMe8cTILLQwS/8Q3FI2kw1nW46u9pMH
 s/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sGqwfYFnnhIGpmP5STGGKrJ6Z6vQHlLNcOlMgCn5PgA=;
 fh=XZ79cUx0qjCKeV2m2GW23mFzyd/u74a2G+orjMOdrU0=;
 b=WGYIz1eJg3tNbOt0gWONCSLPb28GRqN7UBRvSWcrQ5RsF4Y+XfXN0XjlcUWwDgB7wV
 TL2vghoHOaVKJCRQOxIMC93wyeFaN2Gd3p0uJIhMJARlNoeVaUr1QaG8u+eh5/zG5feC
 TB1X3mK5PATE1BJHyt4e6qTIONf+Juy2CghEEGfZ5uJssqXfKpCcxZA3IRFrwgWSw0/y
 Wg5fUP/s7nQmuTuWNsAkD0EjLFyls6L/K8IpnT/KxWcAkxWZaNtceaFhEA+QM/8wE6gW
 bRy8vU671MiXovxxghNwmc01vgk+W3BCY7RmheCwxLFhyFTTLOtRkTWceacmzJ8cbkL4
 8geA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789407228; x=1790012028; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sGqwfYFnnhIGpmP5STGGKrJ6Z6vQHlLNcOlMgCn5PgA=;
 b=UQmrzPJ5Yd9nEhS737pmWEfOQOSxUGDGbrMLIWAiFSWXQGwAHPV0ePa5OIMLCVpHEJ
 UVvm6/gZK5Kl/PLsF37VY6/06Haa0yvvwWSx5ccl92ST53vSZJkdtB4calEdUbHax088
 pqMeZf2PmbBa/KYOM1c/vcnwHtl5ncCcjcgDYHV2zxgfHNXdu1WBc9nzULeI77fQMAiX
 cq6iSbb5bhsR5HsaTF0Rmh8pRZQMyOkOX/OkTftrtiZupdA/7akmBMklh5gcyptBeTaO
 oBU16+l/3Ws2w/MOBmiFHDt7Fl1Tdk26mmPulsyM52/PozUCdYXIfZJQyqNMpbLVBRcf
 MXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407228; x=1790012028;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sGqwfYFnnhIGpmP5STGGKrJ6Z6vQHlLNcOlMgCn5PgA=;
 b=rK9NVr3f/wXU+q/ce05abp5shMn+cyfY8SoAPVCLg1xaAQ0JoJdTcl+zM0J9RnM5c9
 a2raPFPK12uGMPK5rkw6pEy41rTK00T4uvDH31lgXxbfgv2qtrFI4CbIuRaW2pjeD5EE
 ZAHkbPyHjpoVINQSQrS4geu8qsFGKPTnvx/Teu6P1ui/4OAB2gyNPR0GppoYwIzhfDT/
 At2+uUwj3kC86HbKqrHaK8/T4mBW0mMVIDf2byI1dwlnDHpnmJH3pFuJgtS3Pq6NvzeZ
 Fw9TiNcJ37HQXETacOYTB/y2lvCXWADpCVU736TdcuwlwkJZKzB8q1vpkLMcy9Tdqv0C
 sccg==
X-Forwarded-Encrypted: i=1;
 AKwUvBycrCVU+wRJPZ0KVV6ihLp/6KuxZqKuzvGkTBmCeZoFP2WO5ylHcavYzJdz6Qna3c/dJAbETNpucPWW@nongnu.org
X-Gm-Message-State: AFuF++lnbhSz8F4UcHflIEheEcQJqS++12L5Snsz86u8XWpeLjwv995k
 ny7CVvae8ujRjiq8pMnw3MR1i6IYfZEH430t7GxJ0E4yq70tyCz6d7Wd1yGbeRbPX8q0Zd0o9k7
 Ogy9B8Y4W0IFbdNSox76IotJG8iwid+U3IoPZ6gfrRwo6HuoBoG/1gdQe9wVqZJ+wDjnwkS6zeX
 8RQZb8b8yNy8a/LVRnRlOiMtDBlbGVRgpp
X-Gm-Gg: AYBFou3b6dSOCdlSmAJlXiRFQ6M1ev8A+8T0eBdmCx+28GacO/+XMljx5EtCkMuW34o
 qLdVbL/EIMF9cV5pAXGiigG9LwLECSoW4TMBJrp6GRsyBUpXkTHqalMj++luAZd69ro8Q+dY/Dg
 f1fIsnItdaTRzSdI1bAmSZVUbkqOGfFa5XCXJYsAfvthQTNLfw2nzvO8vK8Vq60gUkW/qlWJCfr
 Bz0zJ1yrZHGt7h+pQ==
X-Received: by 2002:a05:6820:1c8c:b0:6b7:8396:f3c8 with SMTP id
 006d021491bc7-6c54145726emr1966477eaf.42.1789407227893; 
 Mon, 14 Sep 2026 10:33:47 -0700 (PDT)
X-Received: by 2002:a05:6820:1c8c:b0:6b7:8396:f3c8 with SMTP id
 006d021491bc7-6c54145726emr1966441eaf.42.1789407227405; Mon, 14 Sep 2026
 10:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-2-ltaylorsimpson@gmail.com>
 <2b1ac378-da03-492c-8886-282ecaa88404@oss.qualcomm.com>
 <CAATN3NqdRMprWLM=kFtOD8TitwcH08x_SoceHUVRUq03pudzBA@mail.gmail.com>
In-Reply-To: <CAATN3NqdRMprWLM=kFtOD8TitwcH08x_SoceHUVRUq03pudzBA@mail.gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:33:36 -0500
X-Gm-Features: AcwNN1WZP6Momq29kExEcqwFtRq9B04ZlIwqlQjofNC69hy1tUHluLMiJ2U2Z88
Message-ID: <CAJ+KCYM4-s8oVQQrmNPxxzVpmQVp4+xigz7X9pmb-AhcvL0=bg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] Hexagon (target/hexagon) Move code out of
 gen_start_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0OCBTYWx0ZWRfXxX3NQ2qpxmSg
 Ucoezl4G4cJ1/LxwYN9BXIE7y76Z7HlBqHskNB27kqFg+BRIWq4dh7+2rMTZqnwKq0hsIPp9Jsj
 4DMtmTAyVIHX/qwcSv9qg1e2oIlsoKg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0OCBTYWx0ZWRfX6CJdStGs7WOY
 hIfXRolHNJ54SaoyELe0ChKxNgZw5PA4WvlMkJXuWD7I7bmmjLxUEs4cyzwHOhcgfBOQz0rrUeE
 x6VuzFVZqPfSt7JuU3SaJZEcJixdFW58Xr/v5EZmYbyvvDA15E4MY2/GCO9EoP0NkR/OSacMPXI
 2juWtViXdj3zDDtqDgoRwdQvRu88K3KoQyNneGEhHAxGfDXjhzId6jHGq8OSuz6/nlnhB3KUmU2
 LQQtGenO9ktCZZnaEgoGhIeGh/8ChVyXb0b4KSX0YvscwT12Adj8CcABGs6LVPEJaEI/LfFbRx0
 HEzqD/AQXYX1MHLCjy14QpgTe5ryZDNtEp+N0/JHjfhnGCogph2j7X0pznfnAssu1DZFYJhOlMq
 Rezo+eYWe8xXodJ1xhx7IH1aX12uCIcDqlPrfS42RUt/CXnDGFsIPC6Uo4gd/2QZNHbRKrQOE4P
 GhZzG0FiLX0WQomy6Nw==
X-Proofpoint-GUID: sgAwNt6psGIKXkyRBfqiP9LtndBDkfCY
X-Authority-Analysis: v=2.4 cv=Ie4Symqa c=1 sm=1 tr=0 ts=6aa82ffc cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=jBXn-RcPWkQPmHhmznUA:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: sgAwNt6psGIKXkyRBfqiP9LtndBDkfCY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140248
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> Move clear_pkt_ctx and analyze_packet out of gen_start_packet
> Precursor to adding packet validity checks to analyze_packet
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/translate.c | 45 ++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 19 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

