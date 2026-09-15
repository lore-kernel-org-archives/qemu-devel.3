Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4001C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XlX-0003CP-N7; Tue, 15 Sep 2026 14:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Xl7-00031D-Vp
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:20:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Xl6-0000SV-Mn
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:19:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FHp75n3784046
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 18:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rHRBaRguoNXueArTtkku0SFVaLHLFFMrfJaVMlk/agA=; b=MwGJFxCo4dK6S794
 R7JRxed+yk2CArvZrvmwJSqtz0XZMHdhsZ5mp/V+Ohky4NYeIn+DLMcMeugCeARN
 DHCC/3Vn/H2fW5o0ObXkf3R7aVMROBpXLxSnR9Hro4NJLIcWJQVWHXqXUBTQVPaP
 Ic1wsSKrL97Wuk5TpFGN1oX9IPA1FOOtoszIrOB52k+0LfeMHq28ihoihzWlhnBs
 js97JHLgUycd+PDRRxtMWudE7+0b2WKptFSz5K9ycW1BB3Y9Haft6BO5bhxYn3Ht
 JxtbgTw+MOO8fira5F2xUrjKSm9h6JG6YsaMNjH4kInBf7j0xy+cwC5Lneyxft7g
 gvLqng==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqageg8a8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 18:19:55 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7f4fa572ba2so3045977a34.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 11:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789496395; cv=none;
 d=google.com; s=arc-20260327;
 b=YYBfKz+60JNmeLXuRMrHsJepuuV5GVZWlfBDCO6x0KO6vtQCh/WboKSYnslM9g57tP
 QW22i0FiVMskiAYnnrSGJJLICv/4e+aZilbOCY5DjzxC45Gc1Z2oQK3sS+CW1V0BK+UW
 J8byEEQvZzOp59PqhaPaLQqzaZ85Y0xCqR4iAd3+c4a84zBKUIctjo4ETsMFq0Q2r/Ec
 femutuW0lz2B4CAv3c/FCseBR84yD6+n+Ta8M70ZUw7c0ioDRiMsyU2vegraxvnzKPNE
 b8OqSOKyVGOjtuRcmH68nRED1NtWHJHWPdoh8jseFINACBC1TrmgyDgSwLOBNl+mjf0C
 MQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rHRBaRguoNXueArTtkku0SFVaLHLFFMrfJaVMlk/agA=;
 fh=OSkAXfMXEjEHEK9eR4/7X1OkKzMaRPS7D6WMhg2fqKg=;
 b=l34CHqX2HPjSQ9cK3hD6TFVDy6EszR5tPQVUJLB2Gu/TZJF08TQRbM1rNJjMEALY5q
 8mMDLeZ7jxqPDTvqYwS/11GuA8LWt+4HvEFzQlr3Jy3YDEnRlSxtblNDwSF3sGJk6WQY
 u0IQtx19ph4DCfI8EMZTmlxlyqQN9Xnq8MvQqOcXEg3CWyGsaQCopT8ppaSff34W8/is
 VnFUU1OZXq4BY4ylRIiEJ2UC/xGHVy8C6g9BIULHcYaBVRxULgCfnIsodsAeQiIEwBBi
 vDWSwdbHIVIyaEVKR1akYWQCLTW0tbZjP50+WcLDuQbzcj2WQfXRrA1khPru/hXlBztJ
 1XLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789496395; x=1790101195; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rHRBaRguoNXueArTtkku0SFVaLHLFFMrfJaVMlk/agA=;
 b=M91G0RndXU1atg7aUrvYt0ZWzmX6BvG0doeLda++C2+CmlvblG2HBl/O4cYPvfRcd0
 CnRqNFAzFRAweLCJPK0ODT/U9zVRzDAtAWZMP40WZyUkESFu1BrvxYPskzz5/2b/d8pg
 OH19MrX+7FH2JFEqPJ2XTzi/fXTF8r+jAoAVI16jt41EXggFZMfzMEuL50c7gcjPkK+q
 VHApNxRjA3DAe4IfYogEj2D9phPCtVeRN2nrRBnet2br33bdB5jMqNlzMB2oiPhv24Jn
 lc/9bxD/K2E6GmLyIMiZ+uLML8jPzz3g36922Fjx6r9AQGju/johhDh1/lI2dh2ZHSdQ
 uHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789496395; x=1790101195;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rHRBaRguoNXueArTtkku0SFVaLHLFFMrfJaVMlk/agA=;
 b=hUCz+VxejpiZQnvJQosTfCalxHiYDU442+QlHKWu9+ODFbAwrkRiyUKtbzlEduhHiC
 4Z85LVfz9YEL+Xi8a0BTaYCN25A1VF5BNZUFpqSsMr8LINO7fuk4AUjAgeAtf3Qzxvd8
 sRUITx0XuYe7vXxmwx9V1ql+gHlThPmcdsRUY61nZldDxUsOItgNdU1OplQDMVU7cM/a
 aAlHM/mb3LxGctMD8WTzrL/SS9mA86M/g23IvPXcNDXk3U5e55XUTK2b2v63VeyyiP/y
 huJgDOKaESCeNmSWRTfs/z04nxzflRBAYVlzU0yhL6OhUHLirV4QS3iEwy8sy1CPc+5W
 NddA==
X-Gm-Message-State: AFuF++nBzhTWZhJgjEFCX4ZtynBDA5rWQIpQCM2vsLAzD0dG+s/q/LTq
 zmsHZ/YqK5o+yxGK9QMVJM4SNrCr1OiBlF+fAtorz/GektDu439Ht9x9+EpsldH4GFT7j84GU0J
 G/EEJOJUaKdg97an9umKKDgS0isA8/zRmjOwX+YlJMzP+UiZjx1YsHlLgPezLT9BE6JUhIh+0yZ
 GitrDh3qEqP9HkIfdBX7jfEvFFpl+sI+8Y
X-Gm-Gg: AYBFou20LvIHEj+y+DCW4jWUfS2fhmwbs3qHyQUnPHhtpVpP4dJOjhAIfxyf9RErdJo
 2CBH7IoZY54bjNPK/OYOBRgXmb6e/o+Ux/sN8giyA2pu1Nq3ldxK6oYX70qYUqPG9NHG7R/VUXN
 MyQBtIcwraKgxrok55zinKW2vTCU6t7LZ4W3rLFhEg1k4ChV3vyLxeoMEQeScoJfbAeksIpRfep
 /eibqqc3W8AFipanQ0=
X-Received: by 2002:a05:6820:1609:b0:6b3:6236:6fa with SMTP id
 006d021491bc7-6c53f050dd0mr5334640eaf.21.1789496394968; 
 Tue, 15 Sep 2026 11:19:54 -0700 (PDT)
X-Received: by 2002:a05:6820:1609:b0:6b3:6236:6fa with SMTP id
 006d021491bc7-6c53f050dd0mr5334606eaf.21.1789496394496; Tue, 15 Sep 2026
 11:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
 <20260914215037.157879-9-ltaylorsimpson@gmail.com>
In-Reply-To: <20260914215037.157879-9-ltaylorsimpson@gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 13:19:43 -0500
X-Gm-Features: AcwNN1VJu-yEg6RgvTOxDl57ipD5H6nyYWsWVJML5BPRKIb9sbf1nAlK6_6JPdg
Message-ID: <CAJ+KCYM-kt6OhFQ-UG1nio08qChTHMAKOy0R7idJO+OnBF2MhA@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] Hexagon (target/hexagon) Check for greg
 multiwrite in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI2NyBTYWx0ZWRfX6hvJU6m/IyHP
 vc3EebWSLG4sxxUma0JGu0C0/HpW3LF0pLZLCw2piNozKLqdYVFVkV4pBGh5GN17bjmUS1UUOAj
 DK5Hbs82jjm7PA9xC0UoC/N5F/PjJaM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI2NyBTYWx0ZWRfX2Qz7PmybXneO
 tiBcARk/oG5RFEiJ12kEJ6o8xfzVOMNkJTADgoddyG+0HRmruSs6dmaQE/rEsuITFg9r+np4jI4
 8ZlO1al0xetXdDQyHRDGvvH46oqWHNJht0jpPxAWkjoudvrXVtTDt2z7zWzlTCxRj+trTfOgPX1
 yEWXVrJzALOqs/nmsgkrMQknq40DGBpXzY7+JdeYUJzKblLxRsdV2rueQQuHU/H/xslSaMIDDwg
 +MnF6JuaLEWztaRZCxcirBjvRuximNtNQQKRiuSUuNZ06k/7+hX58ZxkAIxkcCafL55yhXZNPlB
 xd9X7PcunMdbO8yEMEgZRD6eJQW31PNoy4PXjNGra/tFAVK8U17RhHz9axVTHsx2+u7Smio1yqW
 xu+ZbpF1fCa3+iDJuF8Yh84BVlLQWBDTfMPsR2ZxGdBqZfVXERzmpA3z0f4V6jKaAks94Wxm7IT
 cOECcc3BVGHEQvW9ZBQ==
X-Proofpoint-GUID: P-rfLKcG4vr1EShgH6TxXzjX6iHQyfsQ
X-Proofpoint-ORIG-GUID: P-rfLKcG4vr1EShgH6TxXzjX6iHQyfsQ
X-Authority-Analysis: v=2.4 cv=PcZqFShd c=1 sm=1 tr=0 ts=6aa98c4b cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=oiUj86p4EGMqR00RCskA:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150267
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

On Mon, Sep 14, 2026 at 4:50=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/translate.h | 11 +++++++++--
>  target/hexagon/translate.c |  8 ++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

