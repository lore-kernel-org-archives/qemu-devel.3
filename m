Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715ACC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42Qx-0003CK-Sb; Tue, 08 Sep 2026 16:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x42Qr-0003C3-8C
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:28:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x42Qp-0003Kq-CA
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:28:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688FdfAR3964563
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 20:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 muzmemcJNJQgBzhc4U92g+/uP8zLwcYFlPSBEDpLyPY=; b=aNnhEH1ZlTKK1Q/Z
 48rJRKlP64Z1cGuMyZrR9bCtjdeNnGMmuWMHSFrJp0u7VX6e3qbbzwLwhQeQ8PuJ
 pvTl6z/IJWm9KfjjCppYKDV2IytefyCTqFfSGRADJMjxTk+4aClALGfHYtprkojt
 xFFmqQxFux/AO/O0O8fEHi9NYSLEn8w87o26XGHyP6UoIt8nCcvJK2YCcSStbmrU
 UvNNfRLymdE0Qsz9hdzD1rkIPZ0j2YRb1flSHXcuam7FM5UuLiFk8waTes4BYfEV
 xWR0OFvXZpRn64ZzRDxlrfpB4QKaAqNuYXxXcBscV6y3ptayE6tiI8cKWJ+55phK
 SK8lAA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjfp4ayay-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 20:28:37 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7f4e0b45e4bso5369403a34.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 13:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788899317; cv=none;
 d=google.com; s=arc-20260327;
 b=kk1S/gVg4HFBcoNFnMuqu0eOVn6Shp8Dci98yaJE6ygXdu/ZHejQe85Z97u/OnmdjL
 jAb7drAQF6X9ETn5CjpVPsDIJ0ECjcL2f/2g0W2f5igGhJJLsnzNDnGNvvVw37yWeibW
 m9qTgk6DfMO6bjagvd/iUwqGFgZ/SlKZ/kN+8AhFHWwn8X1HS7OWXZqdGsuTn/invZAz
 OSE6PgevvvQJl+BCCQ++vmaXmt0Pj2BguPT2NyFWvKzHdt+yjk7nSbxHFuX+hoTNQsdq
 I8KIexEfEZJIEUfVy7w1dFH5psWHYXpBZC0bvNqcVr4rvMW5DRaqwXk9GPTae6CNm5M5
 D6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=muzmemcJNJQgBzhc4U92g+/uP8zLwcYFlPSBEDpLyPY=;
 fh=LfxqVHs7iB+giXalVcz/pbqkbOXeZSBmGzkNDoDAtdQ=;
 b=i3nz9mOnZHf7DsCjJa7n5Aij8Yz82r5+XpqhjUQs2QJQazX6xV5NDitCHpjrNo3b4g
 vxQvPBGGOM8VmYiTnXV/lfCPKrOcqfoU88ztdxPdmDFVJ8ByuZgiIDrIn9NUUlpjVo66
 sZYCFFR2lFiZu9HJm+T8VstCR4flXLH6kXmsFWt8Q7gkGdMrCiMpGBR/FlRke7ZldJey
 8RD1iV9bp7qIOa9GxlpPeYqpIpQxXtb/ZvV9qbnA7DRn3+QT4HRdx952eVndVRWTG1Gn
 E5EZ2Gm5xuKIfVV4YaGcx0Qh/qCFi0sjXd4D8wVC8MUFSx1o9VeDNPOv89b9MVZQtBYv
 rJ4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788899317; x=1789504117; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=muzmemcJNJQgBzhc4U92g+/uP8zLwcYFlPSBEDpLyPY=;
 b=FWigvpltygTYI5j05tieLO0ZAlOJ4yv9077UbixVKecNMj7D4Q3Y1tS7vgwTV8aYnr
 pi5pLwuT6Z5IeDHgfcFq833qlF0LS895RJtRauWeOlN1wlzPLR3Px0/ypqT93zFdr0S5
 v75WnDkYsk5o8V/oMWfv1TWgM/nb6MfB7I5mdfyzfIs5agw7ERwyok+v6plkx6UIKdjh
 b/gL7Py1K1A3yGHHsbTI8OztmMQas2t/N6L66R6jo0vo4clT90nfuDcRZT32ljlJ9FCV
 3KoE/QCGn2cm3VFQEyASpsFWChSXlHUJc/MvgHgRXFG+J0cEXljB+wRym7HctOre1ZQE
 07Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788899317; x=1789504117;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=muzmemcJNJQgBzhc4U92g+/uP8zLwcYFlPSBEDpLyPY=;
 b=n3TffCcjeGOlntCAeCdLsgzPatBNtkGbl7DLuSxgli5YeYiOuU6ZYrcKsfnUiE7ySk
 z6NFL5dIm+4eksF4/2vvMdSvC97mPzxDK9/35Vpn8orPfBt47ZYdVHavlLpEMc7Ib7kb
 5vT8kt8HeKUiq2eTlnxA1K+F7itORFU/PdSIYYH7SKc1LJBDIIL+jYOdmQ/HxSmKZ6Es
 KNnCOIw4tnbIlU46/SrxQssyWCrDc9bObSueu2dNhRjdoC0H1bunOv7lOo+pe4kEykJm
 n0HhXdzlClrSxW1LVGlRWeNjwRZ3Xeu4+4KofBh44Hw0kvRt4U/e64Tbr2AUTCXuJxqz
 F9Pg==
X-Gm-Message-State: AFuF++mHbo5/ToPkugE2etqc/ROFD6Uc6ygBPXWVl/Oqc6o6IHiFb5L0
 wn0QvczYbOneJzZZ1YKvQFthSmXxbjmLTYrjJCcrHqkdy4yBHHgRbn0AJcrXyafZRKY6BSk6wiP
 CYWD0UBEDdJW7SyFvYd8O1IVI4Jup+ni+7JK9Wvmy9bpbYmEqkrUUJ5v4KVYm1NVo52o1PrwvdT
 r1286gt8bH/qXtwb/cQFiiU8hcwX7tKVMY
X-Gm-Gg: AYBFou2+fCbGNuHNZmDXhYBCGMto2uIOBlW1CUR8oV/z5FBXOXJUW36Kg/ibswJpwlf
 28jcZFbqm4oJXsuQsHQXJVJWukt5XxFOj6WG6/re78kaCUnqsufMR4GWu3CtBJe6cXRyXABN1eg
 5xtpmJLRznGoHhhFo5mhYe+zDYh6acGtjHDd/KjrO0sPZRYraDN4KyuxMMDA==
X-Received: by 2002:a05:6820:4c09:b0:6b0:5bd1:4722 with SMTP id
 006d021491bc7-6b6faee256fmr16607438eaf.13.1788899316715; 
 Tue, 08 Sep 2026 13:28:36 -0700 (PDT)
X-Received: by 2002:a05:6820:4c09:b0:6b0:5bd1:4722 with SMTP id
 006d021491bc7-6b6faee256fmr16607413eaf.13.1788899316230; Tue, 08 Sep 2026
 13:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
 <20260908133512.2353957-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260908133512.2353957-2-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 15:28:25 -0500
X-Gm-Features: AcwNN1XBp9luFPikhI-4oNyOP7RKKAMBYSDyh6o-CEFL-XU8DwATxAQ_orvborQ
Message-ID: <CAJ+KCYNVRS2Z2ogSM8MWYX=1DnqxQcqvu1=0S=8Fj++-yP=eOg@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/hexagon: add the v75, v79 and v81 CPU models
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Qu9uG1yd c=1 sm=1 tr=0 ts=6aa06ff5 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=ckDaTPEMxCK0iBzLnncA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: 10jXZ17aYgnK5s5KN9fiWVq1tGM2Kdcs
X-Proofpoint-GUID: 10jXZ17aYgnK5s5KN9fiWVq1tGM2Kdcs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIyMyBTYWx0ZWRfX4Zm7lIlJhxpo
 lk4fk2E0uoJL1MD+bQ4GENEfdmyK9oyOoHP9An5x9E1Ukc+UvUXwoEg87K36afSGabCMxL+TuB+
 YslfRJHsUxzJ8uoVkpEqEMPopVtlJzFwgI4WMkH9fdCyXKwLhaAxZRzMWefUVRKb6jmP90wgvhm
 YoGyhSY02q6D8sUL7KOXKuUYfIClALC1pwSBOkwp7MurfLMp5lbzohmOwASpPxPm7tTlbFrjZdy
 Qg2Ro07ZqG4giGkiwc8EAhQW8039JsFJx3v0P4eqGwGUJid/qqOkZ99kBgPp8xz4y520iU95qqD
 L+oig32QXhZXwj77/6qa76Ng4v8yFa1KTS7lfkA82S38VbqzR3XM+/TmoNrSffFh5StUvKGvCZW
 h36U6FqyUUL6ZMqiuFpSTYDGldGnqSmLJViBC3PeVmved++YrwRHS9mrKTYRAti4lMYeWQQ7Xhz
 d/Y4e5e+x97VHLSbhzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIyMyBTYWx0ZWRfX8rkQaDe3//oK
 4fj2OsJCzRfLHDxwHuqowgBULiOXBJwV6Q7IO0tcu8AyzirpZbz3lCd6XyzIcFmLqXVke7iG3z4
 SMxxcpg7Pr3MEFak93GPYdNyLWem4kA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080223
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

On Tue, Sep 8, 2026 at 8:35=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> v73 is currently the newest core this target implements.
>
> Add the v75, v79, v81 CPUs.  New instructions to follow in subsequent
> commits.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu-qom.h     | 6 ++++++
>  linux-user/hexagon/elfload.c | 6 ++++++
>  target/hexagon/cpu.c         | 3 +++
>  3 files changed, 15 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

