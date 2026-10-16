Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A158BCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHjaR-0005jo-W0; Fri, 16 Oct 2026 11:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHjaJ-0005hb-IK
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:11:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHjaH-0003c2-Qd
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:11:03 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5ndw2914754
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 15:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KDTUnNiLGCGSU9ffMQ5pmsWi76SJDL3RU5cruRsK5tg=; b=ZjOYjiCYWAj2m1jh
 O6GQAzIJHqwBMDKhA/jcU+zBHI+iJHjoIdFu2L90QA2Ur65B9rHuhu5JeFsB4vaS
 w+QEHFb0jpYMaTSdu8j43dcY/uznbT2BoDjYT4DLtzB9IqvRz6OZ1qf7BEXT4tml
 ZEaLssKMGav/jEYNeQ/vvw/Z0gmrxC4hHioupumC+k8X3LXMofX4E42B7DiZuCKB
 m/4pGzvmSkuWnY2lEKQovkFqH7AcN1Jopt2N1DxK86ikeneSNIIePhOfSJKWpxxG
 5GdjxhoqxFo0vyZb3PJz261MnzUpRIS2u3QVGrNDYA7L/2LsEu+Cgzs8GWqBgsLJ
 WfMKxA==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbmmq0ern-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 15:11:00 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-45ecb9dd589so112782fac.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792163460; cv=none;
 d=google.com; s=arc-20260327;
 b=M8BzVljxEixkQelZRmGgrxPPP3iQVMqFvjLyAMgZemFXzJSxi5tjuSjQ+Vbd9uz2Rk
 jeZOAO46QGaloNx+ErGkDwa9O8swryWPMKJ6qGk/BW5u4vp8loOWWTs1rYZLVPFiAqDz
 GUTGc/pM/XBvwAMb8FbaspRljeJCV/KBTqLOK9gPW/oeSJUBx6O8ipGDoCFZEghqOBIY
 zpMxjdqiRRBm2zP1FUs6pA2xllbIg3yEyI5pxkCogCpiOQZDJM38oEKkbEjsKH5Pt3XC
 hmmNyJfuZMHpFP0IFSTBpQnoFQTy1PvhmQ819KemDxaGtcb8IObpcXmbMovTtNpKg7Ur
 O82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KDTUnNiLGCGSU9ffMQ5pmsWi76SJDL3RU5cruRsK5tg=;
 fh=BDwCUQnyOohCW2T3saAEoDn+gM7VDetp6cmJKplLvtM=;
 b=lZzjEaL6xd7ORvJzGb79V+exkZKyhyYBvXhqEmbsWsept44u7tFah5T2H/kuGrMiZR
 jrSdUq3uKbtKTWV5wL8aswMSm/8PAnfle76YUVzPlsCImrMaNsXRQv8bUih3Q2sHo5Bn
 iN7PPC/TeNIR4/hxAZSIDE7Zdpt2ZddfMfz64d2l6805niQzhSP8efL9Y7vNUWG96Idd
 5iQ2EwXYqnXjJVCshDrmvzQoXaCom4V+DIjG5eUT+JVpDCmhycQLun5o2M2vSWm8+CCz
 Co6STrj20SMFSyuBvvmlOlnHe9fSp/bQAElTaPovspzXT6pSEwbT1ZoOTrF9W9KA7rBM
 vweg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792163460; x=1792768260; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KDTUnNiLGCGSU9ffMQ5pmsWi76SJDL3RU5cruRsK5tg=;
 b=AnQl7oo9Lf0KjWOg1bFUnbfD0fx646tRY6lFghSEDUntCIoS+3aSjxvBerridd2Pn2
 ZlGkkNVBq6zI8SF2d1udvkvd+o4eB8gCOg8gcshco0Cuzq+Q2tpGdW895HmqoLOZBEiF
 DA6yOnFa7uRV8Cm0NRbiT17mG3fcC5fRgPoXl0b44Ajt5LzUfnsoHnmiETiEHPf8rmSQ
 7eKen4oTPKSWNwHlOmBdEEae3lpQHd60rWfHXY+AiB9a45ulBMkVFgW144cgo5v+L8KH
 v0n4VvNKQNdHJhS4gRvAzlAmnO9L1PD9Yp2pl1tHkAt7CdfrOcew7SeZTGyG+z4QrH7A
 5DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792163460; x=1792768260;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KDTUnNiLGCGSU9ffMQ5pmsWi76SJDL3RU5cruRsK5tg=;
 b=DqdgI/t79xaSUrPgASf55tB2oedUI0JwJC13ViF94XFMlJ1rxEKiCE0uCWxrfMS2ZX
 NpjF/mm7dYEm6dgsMidAcLZbYgzU8dXqbSUQpN8QN8qrYyWz5c8GSGBKbZpb7joYaNUB
 00HLQfsq+t8KjsVvcX43Uj/GvzhH638yTcPyRNQRFNKLPzEHrbIBtuKFQ9CInuR6lQCM
 FjKFkFcUyFQbo66PyYcYUi4/agrYZVWD/Q6qnmcZzlt6lzOkv3Q86Jy57I5x1hxA2Htr
 Yc+LjkgmrNg8V+d7S0W27SaKG53OLM09Jr9RgAJxh7OtgLpfVR/5+nZv7yNOOGz29mzr
 L71Q==
X-Gm-Message-State: AFq9FYKtfe3l0XBd+2cgEiN2K1A3dReyja446EblwLqbhPmSAaABhvjd
 7m46uoA12grtKLZbCge1n3RDftreJR0nKiB2+7E3AB3Ng6SAIme32ZTMLaQ6+P1NFgCyoWz+71N
 dp5j66DZHqY6WODeyjsaUVnu5z3z/eHcBgm5XnjaQo5WyAs+3/fue4Ifxt4Q2yFGc8bPLcR+LE+
 qZOkam4DXm3V1Qfqx+WwtXxUPImdKxSnI5
X-Gm-Gg: AYBFou1AX4e0YvaGsiW75TDMb9fQM3u0LstD1OuAFRu5nYhlQd/cV8bzJJMuzZLSOrY
 L4g8/PUM2GD+IaRgxxynCzYxRTIneSXb7NE/AoF21upurpKLEhyMIc0E1wxid7ys12QZW+tMHnL
 Ff1CSugnSZGs+HR8S6/reWjjbhxZTScehT5DusDtSLOhZVBrw2PH75UdxJ2e9mz4KwmwygN0Tg7
 ToKORraBT8Q7nnxh1s=
X-Received: by 2002:a05:6808:138e:b0:4d6:90f3:74b3 with SMTP id
 5614622812f47-50c553c9e9cmr17100914b6e.51.1792163459843; 
 Fri, 16 Oct 2026 08:10:59 -0700 (PDT)
X-Received: by 2002:a05:6808:138e:b0:4d6:90f3:74b3 with SMTP id
 5614622812f47-50c553c9e9cmr17100896b6e.51.1792163459296; Fri, 16 Oct 2026
 08:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261014195223.3233623-5-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:10:46 -0500
X-Gm-Features: AclHuK-yQpc9htxXnC2gxfE5L4kMhLO98L8SclRtl1fT2kBRYg6dhJDcu_JoXLo
Message-ID: <CAJ+KCYOpgr9bLZ6S7gH3zH3wvzTTqUh9S8sm7frdJgnA0_uioQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] linux-user/hexagon: report ISA HWCAP through v85
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2MCBTYWx0ZWRfXzqlPF3HthxZO
 KREwLAKZ7qbH4YzsrQbHOwzHjqd/lvPc/zy6h8B4G0x/OaXnMhgbSdT5IR3jf0ErZaX3UKv/Vmo
 Gwqx5jPRGJiSQx06dvI7UrDXLr1qpWc=
X-Authority-Analysis: v=2.4 cv=P9uvFSAu c=1 sm=1 tr=0 ts=6ad23e84 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=KJLzXn_fNX4Yjg5shmgA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2MCBTYWx0ZWRfX43RUhCt1FimV
 yI0Dq88KXx44BJCr3qE2hGR46nkJ/JyZkSuYwC/psgGmito9J713yKaJQiu3KguZnZXf2x2BAMA
 PW7w5CLg6XYnY2znagXepRG39yAJpN7vY2uvcFlCT2zkw4Qeg+e734aNex00H3qMzHRve4723ph
 k+5BrjB8prtIZmHIPJyzFm24IbrUYUmvCpfbCGEsMOJVSgQ3l5QLePgpjFua+QVdHhEi+ee7DyM
 /V9Hnu2826YYskk+4kJtgy76HUE20YJu+NmzmzlM+v+S0IO9xiemXJZut9pzAiS6s9L9UlqNokx
 BCf7L7e1NAN4TiY/+BLoGQaQUlnwDFhdH5T/GGcmaaDzbAdyZEWzmh8k6hXm+4yrVfPVkFYdJP2
 i69227hQJmxURd7vqvJHFFuXah68plVX0hbAnzSk5Fer3aTFNn8Ok2qrrCSluFt4GzhDQKzCJpy
 UCz9AAk3CN0rlIMYNIw==
X-Proofpoint-GUID: T0j5jewpKS_aiB6AvfYNBJToZy_TQ4KA
X-Proofpoint-ORIG-GUID: T0j5jewpKS_aiB6AvfYNBJToZy_TQ4KA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160060
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

On Wed, Oct 14, 2026 at 2:52=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  linux-user/hexagon/target_elf.h | 2 ++
>  linux-user/hexagon/elfload.c    | 6 ++++++
>  2 files changed, 8 insertions(+)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

