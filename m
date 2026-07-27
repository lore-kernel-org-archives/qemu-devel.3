Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166CBC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLTm-0005DK-O3; Mon, 27 Jul 2026 09:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1woLTj-0005CJ-2P
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:34:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1woLTg-0003LH-6I
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:34:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAMDEW3604285
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 13:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gJsdBdB0qxD
 Kx30qZlTOzX07ipFMfgfdSQKNPuKqI9w=; b=B5aMSmaS1wT4x9IFjoCIcMNW6gq
 YRvqgheI5ABE6ix7oQE0GvJBog7jnvI62k/GUUwEStd+FtICCq9YOhZnD2oBqSMq
 rxP2sSrgJTkVCFpVj4LqkDccfO4qQQgFaFcsttKG2WYv2KtkaoVYj3KzKU5Yyl0f
 D8OBpxOeLtBF7JvXzOwxWBpLmKHfSa66m6nbHEjyoUokzWiftfT8Vq0hIYbwplJz
 Sd56u75ItLUQKymrwPyiSFktuqAzbhjWhphnSTsnkxLCXDsTOTZ2VNuiOpEOzvAz
 BF6vkaPmoczXK3tO8DY6ikFUCPnaLKtTgs50aMVUqMy19ZuaegAUrdFoN6w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fngysunpp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 13:34:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e5a616d07so1118716a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785159281; x=1785764081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJsdBdB0qxDKx30qZlTOzX07ipFMfgfdSQKNPuKqI9w=;
 b=RL+j77aiVq3wMCI2HP4yl+9r26AXXkuJ+YKnF6xn8lJtM2vCBlrlbjIJIa3NkSQgpK
 uT41pHw3acveFIlP/OIMKzu2XIbGZxDh20WV3jmBfQlX82FneCZ55wYKu1pgsP28JBbN
 +Isd+5CMyZGAQoESS23BHIpItSvPSEuU1SkyS/EswqrbXWAojck2WU3BP2j9VqiJXU9T
 UWWQYLMDA46hQhnQGoYt7qOWTJdw5t3UEcw7oNX2PTt153wwyYgbCvMlT7ffNXRJC76k
 TXU7/bQwKk1iqDv+469W+x2ZyLVB8h5043iqVSxWZiE7KI4S6uC/zFt+FLIHZ4R0ju1Z
 9BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785159281; x=1785764081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJsdBdB0qxDKx30qZlTOzX07ipFMfgfdSQKNPuKqI9w=;
 b=n8MBeisMdAnzPfnoXK093L356Y4yXwMGjjaG1VMz+VZyiEvw2fqS7g5z8UF9KEmz7l
 y19x+lvTelSjSuswNThJYHUejQTyacJquqUZEOEml4mujF2E7LnZwoMjy+rqMTbAdjxj
 vPoQGr3jFWVN19P9x2yjzJOqjzI6maSHGeFEYGuCHEzbGCVjKNmuY5tCbleDGEHPdeKw
 +flpljLq2FBHKdm3kJzBni5dcFZJRvx/2gSpq/MyEM1iKoWnsIHENG80XS+Ef0/KfBOs
 EFmv9ROcBTszMrvwAgMMHdi1CKOGKZUWM9WAaRywRixDCJmCitR6+NRwcyGMakC1WrTR
 ExcA==
X-Gm-Message-State: AOJu0YyPfCL4SOl38UcmrewM/kBVOJZKploXhUNpkMkgcp0WG3BrE4Xq
 czYUdFQSWwC91BsV7MEDWzmpBq0EUnd8yhZwrp5rnytMLWLwTCmueSPe8cVhkpfJGrhn+eZVUSh
 zbpnz80zGnW/ed5XRcsAcjmn/MwxvRP+qpz8xIxgDOJ8HHoZeaumoMI2mwA==
X-Gm-Gg: AR+sD10f7/rpWzFw1SA1GOJUnJMH3ErObBE26Q8EwqZGKXIY1oH26Jy/abKfx9Al1t3
 dieb1NEw52cynfKA8be3ySNtPPa9Cp/5X1lavpvIEIJrSR4Vg6BLu+9xrQHN1CjmFUcmml1jrVf
 ZTdzatnVRlLGMLXOge7BT2OzZIy6ZpPuObz4MlI9DRaZOaNhVQnn1zmwDziFc/8VvUddtf4Bvp4
 /TcrPbNLxTK7iG/9+DmhgUjiJw0bo02U0WeF0IooO1eO74g6VMQ99ivYWjcsxCZ3can4//4lxJk
 twhdcg58wcPPkQBBNTrmldu7lmrpKNDb8V1Waid6u8YrX+naVeGL4sg5pXM68h2GWkUQMOrA//K
 T6T7G6Vzoe84OZvLik1jhUExN2C1vP5QAjx4K1WfsdxzLNKTXYf3dZ/g+KkXX1BM=
X-Received: by 2002:a17:90b:28ce:b0:38e:7d77:2fbb with SMTP id
 98e67ed59e1d1-38f2965e5e0mr8416873a91.32.1785159280583; 
 Mon, 27 Jul 2026 06:34:40 -0700 (PDT)
X-Received: by 2002:a17:90b:28ce:b0:38e:7d77:2fbb with SMTP id
 98e67ed59e1d1-38f2965e5e0mr8416836a91.32.1785159280087; 
 Mon, 27 Jul 2026 06:34:40 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419e3asm32165992eec.11.2026.07.27.06.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:34:39 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com
Subject: Re: [PATCH 2/2] tests/tcg/hexagon: add slot-assignment tests
Date: Mon, 27 Jul 2026 06:34:37 -0700
Message-Id: <20260727133437.2610444-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260724171845.78440-2-brian.cain@oss.qualcomm.com>
References: <20260724171845.78440-2-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMCBTYWx0ZWRfX5dJSH+qc6HHV
 QtfrtJPIXHyoz3YRZU8kLi4qomm0HGZUXATlSE+K9TVhzEI1K5Yh1BzwjfSWGatEjb2V8rXh5Wa
 uAIwtBQK31fpV0O3wCxy5G5xoLT5Hy6AY7SicGJNfBh8sF/LM2DX+bWF3+3ciESNxmX2iqJOk5l
 j7oitkmPIVSG4kfJn5selZZ6b56M/Hh2eE/dLdg5j0lawaSV+ankMgQUEi5CISd6O+11vnJJ5/D
 gm3uiw7JQHdg4JaGKzjYYlpxz1xcMMEMGkTCYEQPN0v+AKpwt73M98Njyj829vCR0sAbMiTdGTq
 sT9742hvfpHnfqUjhLD1pqFp0L7dhzqOESL9iMDax93BhHthYCaxVdriSPJkqM0Fw9WSiE99V3x
 yU7+8Fr28bOK0BEBo4tGLAuaIXVgLLvfozKZQRPs2Kb2UNHM+cxeGqc7+fg3JMzf0Sj51vijOh5
 I+6FMKMin89IMjVTnCg==
X-Proofpoint-GUID: q6OfcA3_frG-tREXzskMHArg6D6c2C53
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a675e71 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=QQwjxq2vsnLLEq96bu4A:9 a=ZXulRonScM0A:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMCBTYWx0ZWRfX5dazdp1JQLk0
 34o83y1NY/rfDH0tiV5jJOTQMoQpgQQJOvuZcSW6MvPAR+gG9DluVW+yXOenpuKt5exYi9277I3
 VBsf6Rcqdv8KlneaAvGFxd89QM9JRUw=
X-Proofpoint-ORIG-GUID: q6OfcA3_frG-tREXzskMHArg6D6c2C53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270130
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 24 Jul 2026 10:18:45 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> valid-slots: packets that legally share a slot and were wrongly
> rejected before the fix (load and transfer, load encoded first;
> dczeroa packed last with three transfers).
> 
> invalid-slots: unassignable packets that must still be rejected:
> store + duplex, load + indirect jump, three logical ops competing for
> slots 2 and 3, and five ops for four slots.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/Makefile.target |  1 +
>  tests/tcg/hexagon/invalid-slots.c | 72 +++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/valid-slots.c   | 62 ++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+)
>  create mode 100644 tests/tcg/hexagon/valid-slots.c

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

