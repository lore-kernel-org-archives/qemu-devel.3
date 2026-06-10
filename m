Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CA2CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHPs-0000Qn-St; Wed, 10 Jun 2026 07:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXHPs-0000QC-0J
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:48:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXHPq-0002TR-J7
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:48:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ABNScS1032948
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GEHj/sqzLMJ1RyJLrJWLtnVi3y5M1V7g5LAUdClBE2c=; b=XqnqFgtqh83dTVic
 T+zfdQIFnXKSSz8BdgFrEltrCOJrrAF/iArSylKFunRd9RN3Q9mgeGat2kQ84eO4
 mvjCyVQn+13jeNBEdCA8GGKxZfCDBB5wPfYlY6a4+1OOPG76cZoGq2SNoUAbmOTH
 y5CUJrdMV/IhB4NGfgmwXQTrvLkgncBJGan0Q20i1dYdKlne2iSAXLosEcv7+Qqt
 Bc2fqiPeymNU1XAwi2jYnt6lo5jotQUeEfr0C9yOB3jbRl7qKQvx7J0bInUx9vnt
 Z0mmZ8ftrkxKjXVHZKSBemoSpuZwyIWnp4XNGIAUtHanjDoppdoQ9oXdVEQAvXKe
 Gmc8iQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwr2j8ts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:48:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5177b8def69so141374241cf.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781092092; x=1781696892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GEHj/sqzLMJ1RyJLrJWLtnVi3y5M1V7g5LAUdClBE2c=;
 b=kxwwfTIltexfDSlBRq3SJco06WvyNvPdWVh5+Q0LCYuSOS4Se0Zm0R55uWPK8RexmC
 XecPQ2L56jyIHMe3XwH6F0sEdXNfs7j9YDHnGubTJtqH0Q3ZrlwavL88T89+R360zUAD
 XZ5lbGyLm89Dqrzc5cdYYi7yxwEo3rYl9n0uCDBLdJLPHAH0FtQKAwyBjx4Cn4o+l1rP
 /+nmiRat6weqR+9B78DEl4482w+UGGEHLJpKhYBiRYjMEPf4v4PmmI0ibpYBJAo47oy5
 Sap7wQTc0/tnsRAG2HfkSO+nhOT18oq/5byTV7uo8VopdhKDBfn+KCMOv+mIbbVgA1hE
 3YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781092092; x=1781696892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GEHj/sqzLMJ1RyJLrJWLtnVi3y5M1V7g5LAUdClBE2c=;
 b=bsE1yZM3Umf0D/BBTNmCTrHoNprsBJ1rCqLadLjkttcvHJhx1C/pSmAsLSpnP4xXKY
 pU5rW7iNNtwv7OnCV3De4wLTMtT/XysqIm8v0BbhfChvMwJFSMdgCqml+GsCJ33Ik/ZH
 LR3Uu1kNB5KBCXmc/jPSrc6CoqCPmeen3+YiMkJ+a8nIdPgBNcpCO8WuCPICFkKEysFw
 QGqypPF8oGg8q87P3hIDIUM4g7fgGZTb4LibgdIX+4DjE7Dr6xosqzHiOVxYH7UOsWvD
 lTPjmP0Fvss5F+/xIalqO5Bbxt8bg7zZrLteAARPyQ1GeWFST8JbdB4DCHMv+IIA4WXz
 IXtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NdYLZkws8W6LklJHKrDU0rLfyF/sOmufedxvDS/07MDRMDed2n6aqQyCSpLjLlGh+35Zg6H95PVXC@nongnu.org
X-Gm-Message-State: AOJu0YxF85YBbofwG+tSiywvJXpoUteva4xmMhykItYcMLHQazgbzFif
 3/TzXPQ8P3Tpmk0hju+PH/Gc3nR/9QgRQaJa63Mre/ENYt1jkJJAMAoT68fs/qMr+YaeP8g5NlN
 kpwXrq/fakALKpweCWvOjSWSeDRriDGoOaQ3fyguQttCR/b5BRyrxLCVemw==
X-Gm-Gg: Acq92OGbn1ldQH02v5fqIxFueaZGaxjqNKzjlij201/qiisvSxmRzg70141ZaMfPUns
 m1vEkeK1BtHAPSNp7UDWHdVu5XLHVujWocgT7r//gnkjAsjR4sjlQimmq3N5eC+dd7pqerl5ktf
 Gtr1O/j5zd289nVsnJP41jwf/zyT39jNsmnqLJlXRZ7e5rPpfUoVEnMDACh+XW1XvZVyvDrj1u3
 JWmY+FZTvRsiuZMbk+7uPAu7BjI42IOtaTDYRuOQGGcSyb9Lg1g9eB5H2cwoqFwZ5Ti/ZIQgS2/
 qzNfXXPxzfZJ0I3b1WAAXwT29MWvUVx6yGfB6lSpFBGLCrm+UsCTVzZIlSUPcJz+y5or/MyMYiU
 oAo2YRz3EaoZx5dyL3/g6onkb/tfsOZ4wthO0LahzhXxgrJ6IUkPc9dNFNZYOOxBChNP0CVayai
 GlIho=
X-Received: by 2002:ac8:7451:0:b0:517:742e:d855 with SMTP id
 d75a77b69052e-51795bcda3dmr262403561cf.34.1781092092278; 
 Wed, 10 Jun 2026 04:48:12 -0700 (PDT)
X-Received: by 2002:ac8:7451:0:b0:517:742e:d855 with SMTP id
 d75a77b69052e-51795bcda3dmr262403211cf.34.1781092091885; 
 Wed, 10 Jun 2026 04:48:11 -0700 (PDT)
Received: from [10.156.84.244] (49.170.88.92.rev.sfr.net. [92.88.170.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf051770c7csm1188045766b.12.2026.06.10.04.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 04:48:10 -0700 (PDT)
Message-ID: <11300e7d-f28f-48c3-97a2-0c2b7a545dae@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 13:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/22] hw/m68k: keep QemuInputHandlerState in next-kbd
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-14-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-14-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gu1yPE1C c=1 sm=1 tr=0 ts=6a294efd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=YLXAUxGLE6hMr2F5uSHVqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMyBTYWx0ZWRfX+Ov8En3mcHG4
 wwEw5Ia5P0HNMwIbyFQdG4LzNFwROQVtRUXuNnYA3cezJ4/sxxjpjSR+WKYTyZ1v7L4XjGPnprP
 SOz49mIIjEMoJSg/JQV0qVGxrZbjkyHYTbWWO9DA7jUap1Yobu9kkoZUE6QmO+/QPXpV8qaqNZL
 VGSGDn+mBP7Nfa/OhMz27PkQyEL5PLOx4TOiSKESsvdHyrwwErwBuP9ysAjGi8cxKBYk3o9Iq2x
 AIoLVor2S7yfpLvqzabUjxSP5jyj/gv7wmFvQbJod5Mugp6U7o5xriZ40wmUSf/dXGrOjKjuxmr
 SBUNvJHNLqTvuNF4WjunBNG1IdTxXo4TzLJvcQ0fjEQR3AFcitLY8Kdwz1uzwv+ebZInIZewOq6
 C3Kmn/pMUWor7nKoNqc7oYR57b1j03u6CLLaWLY4g2cHMKJ1zvL6tUQBkEfibWfNq1hiw0bQyrr
 2feN9gxEh28RjcCZY1g==
X-Proofpoint-ORIG-GUID: kJTqPyTVXDrZgvmpSeHLvTddcmaaXTkm
X-Proofpoint-GUID: kJTqPyTVXDrZgvmpSeHLvTddcmaaXTkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100113
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/6/26 12:56, Marc-André Lureau wrote:
> Track the input handled state, and dispose it on unrealize.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/m68k/next-kbd.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

