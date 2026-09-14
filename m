Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C2DC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CW7-0002QT-TC; Mon, 14 Sep 2026 15:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6CW3-0002Mu-QQ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:38:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6CW2-0005EA-Bh
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:38:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYNNk2639837
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K3qnreb/TCEsqS+f/V5bTUSPulWm/kd7YpBzpVoRHN0=; b=TpZAjLYV/uBb79ta
 OQsQ04DDYpWq3yBiGvKlOEyT0VXfWqfyTerBIqVQn1tYnjNlmbrzbyX5JNc2TGQW
 KhonxG8ArLFlRDpy2yBNPiMkmSC+SN1LdJQY0apXbyAt8gzs4ZwefOFo937UVbuE
 Pk+UnmOXOlDPPmp9I3OO5W9YyaMfCC1B6nU8g8VenrxmTUbSwZrq2doZjcEYtVJ2
 EVNeUjFkuEVwDwRcS9LGGIggyKBlWSOIwY1DnlNsNiWw+XZ49n0sXMMMO2Ke1VrO
 OutjvN6Z+oGgRYM0KtwG/9tYgm8aOFErddlZUTyH5p1tMmlyY90xaNHXhcalNrv0
 5WqhRA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeexabqx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:38:56 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4ab4dd46ddeso2534646b6e.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789414736; cv=none;
 d=google.com; s=arc-20260327;
 b=sD8m4dZ1OYNYd3X7kPtJtxl3qjFYLfqeoqZtxBDHIUUITFZLFYwk9eImmCvj4ew/9t
 msRNKxGtvWTX4jdiq+aVTmwEzrTSqVEAptn1GKo0DmwyWlebqhm336foNVZRJ3jYLpXh
 igq98SJzgRBgsOiwJKXiuRrLD4K8Mbnzuqa4stqcnbuBPZnqkKy/n1JY8gn2uYlGvfas
 6crOQwdYBMkO+3L6Sus+LEIB4Q33dj3ovquyd+3p3pIEsjQd67lfFC6YcVdVmKyh+HcP
 tt0IJT0fLkI7+SdXMPHBqDymEu2aQCDXBllcJMiAhyF4EqhWUvjeAroGB0d0H47z8929
 mJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K3qnreb/TCEsqS+f/V5bTUSPulWm/kd7YpBzpVoRHN0=;
 fh=OSkAXfMXEjEHEK9eR4/7X1OkKzMaRPS7D6WMhg2fqKg=;
 b=JhBNLcVnOns/ULC4O5pCe2StD5faOJoN6meoR+/bU9b5ECQclUX68h5QJDZgj2CtYv
 GXt0epE+HkWSMz4/ol/yrE8oS3xSzTq4Ae3eGofJKtJ5SSENbmapSaFza1cqT+X69Wet
 rqKneMN1tA0T76nRwh4hMsEA5vrxxxz36rBy/MK0EhrBmf9q0KmKj3TSMyVr6J84uJip
 d7bNiA38/ogUbCvUD241qHq2V01+K/5SySVrj7Au+s5DBwi4j/iZhZYN2no0W90j3uMZ
 ZY5OMKsPO4h2nHRv1CSSQelzqeH0EFv4b0B/YsaNnEfnNwRFW8PRU7J7vx6qNJ5OHscI
 aWRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789414736; x=1790019536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K3qnreb/TCEsqS+f/V5bTUSPulWm/kd7YpBzpVoRHN0=;
 b=ICodyK7vJEA9axhPCyVVNFwX12UvL6dnT+TsyqfNMnRKpmIY9yMnfEnHvRKbMGWQDm
 ap/T2aKN4h2cfLVjgxbIPL1LVW9CDoBTIjUBzwWIJ+BRu8329EKEeYau7LjD4b/w3O3+
 SenrryXox1xHPLSQoo6665EAU7OGxbi795DqHgjHnVu24lnZlMMc6zwES55KSeR7aF+b
 5KI60G1aLa6UrKPz7LQV/IpMdFRtBAwmSEk3QDtNrdRX3+NCDRWSyCqnmqMZfj1vogmM
 NdfNWyO1+5OVMQ4XIh7fHgEwgyTcuNKfOvSSjLAPcqQHbfRcrBaGlmxXMCdR5AUP5u9w
 VaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789414736; x=1790019536;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K3qnreb/TCEsqS+f/V5bTUSPulWm/kd7YpBzpVoRHN0=;
 b=RtiCvHaNOXMLPtEYefWpCnxAOTViQDSyFJ3ftwyXqESA7jX2kB7f90gDd0sKh5/6Hk
 dpFZXmbcpMD8SiptYeLaJ3NqcAmzEGxh+OmPfVWOBMudyT6P1CcK7PkRzcm56UTm8/po
 v1auaTx3tZ54DFB9F9KLKTkbBQxiFEnqnPtPflI8dZoaM1F/6wJaNDKmDiWxOA7YXsL8
 yAKNKMUABAFHAXgqeS+t9uv2/bNrlW5bQD9UDmENMuoiJG/lDoGSsPPbiqs9jRpczeZe
 AOHxMg25ODzCHL68wK5c5/k2DuvGMWug3Y27KD4wILPx5p/YjCqkGwLhOzdz3dHelcTq
 71Cw==
X-Gm-Message-State: AFuF++nSVM8iEKT/3b3MbPEufnQtIcsS0fBG/TdaJCOFD5K6SANuo9eE
 qjpDOcFs7zK5ZHsPMHjSgkrzwdyRDZpcjHqGKl8U8yfUiQfQ0W4zhPWMqy0GwvWT74134AGcDf9
 LTsSxS4qVB4ujrYZuILRStAOiYb5sc7MQqOknHZCq+myOZHrnn+ENMOho8UAs2p2SsSVQ5SC2zd
 +jI7o+mV49yoFwbNDZtplNyi21hY1rQcFq
X-Gm-Gg: AYBFou24Fa27dDv+IIcLw23scFa9TmRqwHKG3+igeL4gsQ3O4B+8LrkuIZad5UHkrBQ
 gZnJ+D4mSiZ7QXn+SNHEHe/yXenBHWm51DqFpizXmLK34mUgB3YwEIWPnf2ogLFjCY/+oSk84Qc
 yuyAF84JglmUiWnAOrXcXw/NbFnK8AHJwcbEOqnOzP5taLrc0EpK8OsiXe8mzqR0lY7MxTGi1Wy
 MAu54PySxCn1o5Y2w==
X-Received: by 2002:a05:6820:810:b0:6b1:bd81:cc24 with SMTP id
 006d021491bc7-6c53f15bb57mr2259306eaf.1.1789414736205; 
 Mon, 14 Sep 2026 12:38:56 -0700 (PDT)
X-Received: by 2002:a05:6820:810:b0:6b1:bd81:cc24 with SMTP id
 006d021491bc7-6c53f15bb57mr2259284eaf.1.1789414735778; Mon, 14 Sep 2026
 12:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-8-ltaylorsimpson@gmail.com>
In-Reply-To: <20260911220825.143115-8-ltaylorsimpson@gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:38:43 -0500
X-Gm-Features: AcwNN1V7lTvZzFnD5eNzo5t5n7e0_jehwUyHLq-j_O5qlpFx-1eI34wK9yrcJLE
Message-ID: <CAJ+KCYMTXL-m1=zTDra8JjNm6H7+rwJvseO2gf_OWzRHOb6Zxw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] Hexagon (tests/tcg/hexagon) Add tests for qreg
 multiple writes
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI3OSBTYWx0ZWRfX7FgKyILAjdWS
 Yx1q0xvjY2YTorNZcMC0GFZ83iCFAts4nZ76K/lSOQ0m0VRJn/3TlpGcRAsnfcV8dk8AC/NulG9
 UjNncBkULBJ4HiZQoXXzo0RWNSj0Dk55QS33+YY0IjtQZPwyPS4r4L1g/2CZfi5w1M8ekxlvZEy
 oeLyKeY86+/Qc96uOgoOBkCBwAMkMp665oQfyHYhyckdOasvgsdN1KV6oA0oEYzvv/FdbH84aOY
 pEywEsohLVaWINAc6d4pCNEc3eNjS/l2F8IyMECJUE6/KXV6ughaqqIhd0rf1CdLXZ/lkI0I7mV
 znDxNZzbDjQdnkC+SGGFx4B8H09zQeiEwU+SkeQjpg2KV4eg/ktAOCLtj5hy5PzJwQppkUE8Blg
 LhC7w13/v/7WLe1fztBagGhXR89mO008xQFO3/CjYr5J6LGp4nqUBAVPwkL8dnTnA2EKKLNqLwh
 Xhk8VaDcVtZQZ2vEM/g==
X-Proofpoint-GUID: 4hbC-fjYDJ6LB8b0dvOLrxcgzuojmlAn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI3OSBTYWx0ZWRfXyfKWGcNPie1P
 6OMV8+QkALgaKQg8ze/2P3uRXR4tUwAGcbwA3PU+tnOEm3bC+O0F8WkfjBvu57tqZqu8LyTxNpP
 hPl0c80LbkgMQTQAOLQ2W6V9xRyomik=
X-Proofpoint-ORIG-GUID: 4hbC-fjYDJ6LB8b0dvOLrxcgzuojmlAn
X-Authority-Analysis: v=2.4 cv=MsrHeGae c=1 sm=1 tr=0 ts=6aa84d50 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=oiUj86p4EGMqR00RCskA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140279
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  tests/tcg/hexagon/multiple-writes.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)


Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

