Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B11C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4K2Z-0003DA-3o; Wed, 09 Sep 2026 11:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4K2X-0003C3-HJ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:16:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4K2U-0004FY-L8
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:16:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689BU1Ne1723017
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 15:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SSA088jwEdVlVzWdsEyW1HPyW8EPMUM1NqbzQ3QYtRg=; b=iexvyW2sB9cRTObt
 wt8zf0GPnGMSvwQbGnHGdslrdPi1p6FRozZewcuxVerZS2ilK0qB9IH0SaAWXAjg
 0isOeqILluYhuGHk6uPxsL+H55IhO0CS36E4VTrdykIoYkSn2UnVM4qxWy30sSqd
 mPs56bbTmsq7qmjw9tGUvgjLSRcqacf17rOora0uL4+ANAT7+BGeggEVxfC8+pwi
 IKaGPHIJ0vxAwdD+OZJwQ/5RbsoVJewhAnu2hTQGt7vxthOXPwktbqBGvdaRGWhl
 kHOK2TaQSb6Hb87dDwTXpFNF/GqQtkHcbzA2FyKColz3CWQqyywPZKPvq/JYQeJt
 3b7lmA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5cnsa82-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 15:16:39 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4be498aca30so1860707b6e.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788966999; cv=none;
 d=google.com; s=arc-20260327;
 b=d0DJUTC72eHCbmbFvqHiWECj9RfkMF7cxE1eYO2Ix2F8DaE+1Zg9a43hGwFfTj49Vt
 UYJYJu9Yc9WA6CglocsM5DlzKJxAV9PcbNDOLlu08yLmJ5x8nw5hvgKa8c0g2uhRXZnw
 rTP8fmPlUFah5nwT0GwEH9VtfiAORS4ePNi6hOaCjYDoULiE1zun1LY0LeXHfzwS7LZU
 EsP921zn+ghPepps/8gcYJ6FBRaiJLGOb9Xm8ZRocYsLDv7rxAiCDBTX+Jw4XrPQhhgg
 ZzrLubxnjWJpsCFOti/NTqMeaVFppYQvBOoknQXZy2vKuLchRvoDcIjjyxqsEexHp2YW
 IXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SSA088jwEdVlVzWdsEyW1HPyW8EPMUM1NqbzQ3QYtRg=;
 fh=JS/OgZbRfXQVDoN5rCEv3BGagEhB1TLJSS5HOGFUyfE=;
 b=rYGeYzhPTZGOLFtnfkPKLMho1+1JxJYQzUFu+GKN5LdzyiNKE0Kh1/2bVTme06Q1f1
 8TeHzVZfEJhS0B2G3mEM2nRQ9zNr6D8fx54mnbvkdHYnDfi85grSR3ID4Z0VyZHEKANN
 RWyEM/wMKHgxQ5jWtJTnDPxoHkRVsl7mvJ7M50fxUteB9r29G7GpF697x8WmxTYrX4Pt
 chm+U/XNUrgVLsSlz0sX75yIg4q+bMc82pcCPRTsnlzUZ4YGvLCRirDyz8ENz5b7Qd1a
 FR6pK72+0wG1urFdxYIGbrZ1Bsk3/I/R1/6+WNElaipSh+fX9vAAv3Rw0Y8tzL+OF3uE
 0yxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788966999; x=1789571799; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SSA088jwEdVlVzWdsEyW1HPyW8EPMUM1NqbzQ3QYtRg=;
 b=c/iTFAJ73EYHMLqFhnPmMLfmAUtHiGTmiRb4n8Eq1igr+NKXv1yM8syxmwEjIJc19N
 1w5x3drrAYa/Dzv4gwakhlptYnoJW0BlogXDQUGpJDwJXUe1rQAAWTUv25IqywJ8NKnh
 noQGt9D1h3QdPF9VMrjqJm2V1WZBSBBe946qy+EQaeSey9jzgCB1umXkArijXh7+trWT
 7o1JVmC/VKnpGOlBjt0brXPzeeE9GlCWfmeWrR7z4P3i+NUfDfDHe3dWv7tpXvkiJgKT
 ILUSXtZnFUIJ4wkmekgGAD8suSuz+V2FnYqtQgD7We/dQK6loK9ejJ0ac7ezo2sI0z2A
 ZELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788966999; x=1789571799;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SSA088jwEdVlVzWdsEyW1HPyW8EPMUM1NqbzQ3QYtRg=;
 b=I60UULIDTd1UGub2HlN5x/hNP3/mGzVygWVMotrmIBlKu0udl8W0FQMd7YkSXMsp4N
 c0+Jmw3vKmUA6Gte9y1uxKrN/WUU1i3KS9klnSTSwPnUPNYlnK7/Ip6mlofwWpm+ayNI
 mZTVyWJiG6K4rqtn8H6LIBH3cBM/0laqB+WTgCoxsoRKkDkuk3puSrYfwQvEVX78NOO8
 Cx0jRvV5ukY/agQiojZb5vF/at3ugKjrBW99VT0xUxaFYX27ccHSDzchawiecEJmRvV4
 2QgoKrseLjD4TmK4QF4wE4ZkQtd3SZL8aetQGMbnJSd+l/I03xtuLlfRPxxYsAOvBLlv
 lgXg==
X-Gm-Message-State: AFuF++nDMEISWeeQtyQ5+BFjx1JLnd/Yw9BaPOJ6swF5eUmmXMlMaLWR
 UrXoMLwsWKEifXgi3zOez5EfEXL8wCw8G6aUbexo008Ptt7ttXlOocF+e+Zx1/InCbTQGlsX/zm
 LV9XndwBhjevMcEabzDaSWc+FAQXGxaU1CxuJaJAMNjHlhHfO58fWYa+uUxcaEzqm+tMYhUwHSm
 xe6n8pOAUXoK/pcRigP856rGGJBYyDpN73
X-Gm-Gg: AYBFou1pDbZYr3Vwi//Yc9mtP8JBLx7YE/q2tOffA2wCUoyPTvinWbGK+UmXS3gLiTh
 STJr8J++bRymP6Nt4+q+X41Lz3Ko5Or+cm+Xk5LLxisj9IWJbQTqRLq4eB7/HCPX3dK3Xt/o3NM
 ScZF6SU/TQLwoPZoRz6bfB7ah/qdFQ3LhHsjI5uY5p4f5ua8aaxCIKhJta+YM=
X-Received: by 2002:a05:6820:a0b:b0:6b1:be9f:ce6c with SMTP id
 006d021491bc7-6bee25409e7mr1841169eaf.4.1788966999347; 
 Wed, 09 Sep 2026 08:16:39 -0700 (PDT)
X-Received: by 2002:a05:6820:a0b:b0:6b1:be9f:ce6c with SMTP id
 006d021491bc7-6bee25409e7mr1841103eaf.4.1788966998872; Wed, 09 Sep 2026
 08:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
 <20260909040137.3414132-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260909040137.3414132-6-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 10:16:26 -0500
X-Gm-Features: AcwNN1XkrGdgwutB72-Sh_n84a1BM-nqdk4O4zljjEhoifP04mC2n0ftFMcmh2s
Message-ID: <CAJ+KCYMTPZcdAfjP5tW91DePRviFn_rgd8aUT1_nCDEsd8eVAw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] hw/hexagon: add the V81DGB_1 and V81QA_1 machines
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 9JJiVjVFpMmcPvS03kFQREm2B7c0VTwa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3MCBTYWx0ZWRfX8yUwgmbT3J6m
 k3JT/TYaIA6I0qHRiAksg1gssJ6gnU8eYQPH8CtYFCtLqaIJSBa4uK6z5jSp7CEGx/pRMdmu9jT
 ASBEaH44r0XucCShsAHvfVUvCjCG1eQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3MCBTYWx0ZWRfX1BF1/qGHfm9i
 uhzo825PbtBW9AIKfwpKpIKLRSGqrmduJ1AViIC6mUeeIXf5uaqsFebEDo8VDZZI3bk82KwzduH
 CCz8jRzFMGZihlsV76T9aL7m+l5l9ePpH7zUX5VcoBCTK4Gfq0a4N5ViAVeYrKMLtee1o7tza7q
 N+K/kFnmQ+1XcXszdTzBp7bdzASwheINBz28taxV/eqQBJiHK844AMLgHPDrxtmg/zl38XyEbLG
 VOdPQhOV3dKHmHqsJajeYSpbvX6XQxwz04HqoJo7n7nvft9HhCKxm+hJyRLqhNObuylxXFN14pM
 VRPBNrtxZwLeeotTJvrDmmSmbsIhFEduJrOBvzteZMLfGyrH3y/vO/0f+KVxq89cid6cUC6QE6r
 P364j/gHP4pqRlb5NJ6eD0nAVSKLwFLM3/SXeRuslEtxN92xrEsWjd81XFvo0kzMU/oCIFuof/P
 /Y8Hi4rAaRTPfrh8cYg==
X-Authority-Analysis: v=2.4 cv=S+jpBosP c=1 sm=1 tr=0 ts=6aa17857 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=kvQwXA_tl1kM7GFMqjsA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: 9JJiVjVFpMmcPvS03kFQREm2B7c0VTwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090170
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

On Tue, Sep 8, 2026 at 11:01=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add these new machines that correspond to the hexagon-sim machine types.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h          | 11 ++++
>  target/hexagon/cpu.h                  |  2 +-
>  hw/hexagon/machine_cfg_v81dgb_1.h.inc | 73 +++++++++++++++++++++++++++
>  hw/hexagon/machine_cfg_v81qa_1.h.inc  | 73 +++++++++++++++++++++++++++
>  hw/hexagon/hexagon_dsp.c              | 46 +++++++++++++++++
>  5 files changed, 204 insertions(+), 1 deletion(-)
>  create mode 100644 hw/hexagon/machine_cfg_v81dgb_1.h.inc
>  create mode 100644 hw/hexagon/machine_cfg_v81qa_1.h.inc

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

