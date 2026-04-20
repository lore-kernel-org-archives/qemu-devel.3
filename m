Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4329F588C6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEopz-0007HC-Uq; Mon, 20 Apr 2026 09:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wEopr-0007F4-V5
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 09:38:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wEopq-0002AW-Fs
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 09:38:47 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KBdE9m3212149
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 13:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fYokICpGobc
 7HgSAURrBoqvAmQlrnvQorKBkQ8TZTxE=; b=Jcxfw7F8nwTKULKzBQyLQKNeT/y
 q6mt7udhOrWAtY8dv7b4jX4kizj5NM//VxKohwHqmsZKQKginITfn1jkVaFD95Op
 ww0r4lqMLzkS6zSi2P52sN8MRHYh++QpG1vj1CEmPWnQM39TulxBlT1ujsXPNfYp
 c+XHT6bd6/0HhDkXrhh2Fnuex87AwhF200p9Ze/NqsnSNFFYk502SIRGfqp86TT7
 +pOgxEIZzACneLX2BeZh11oL+LrSojZgjGoNVh9E/5oPgj2jCuB8fwpmvaPsDUap
 PQivZiBFJ6im/wukxOrByGs/z3LPKj5pZ4xaUlumfE0ymlXnotxh2TKN1MA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfcfhmsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 13:38:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c16233ee11so4124757eec.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776692322; x=1777297122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYokICpGobc7HgSAURrBoqvAmQlrnvQorKBkQ8TZTxE=;
 b=D+71fdnnHFtZ2fPFJDU2F9B6xyA+VdK/gLPmOHHLQ43Ch4lzplrs1e4hTIsKFz5xGj
 n6VjLzdB/lS12CffqBewu1mxNqqtsx5bxovvdTXAu8MhoRJ3jXZFfSDCjj0CEcFTSVMh
 T6V2jK/D6B0MKzajXCCRw4TU7yOjVgS1JTxuEj5GvAYUdEDC1q5VR8+wYkSf/Rv3WSab
 NzO8cMe/MWU4Ccg4LXnL2CTSnFZsBdTcSPjV866ZDlhjQbUC0t8u6gFteaeEHlmSHbNE
 aKw6kxLu+4SWxF7UG+0psLOUtTcxYHc61iKFiyiePIGGXH/p5CddpAW6A7q6uxy0cIW/
 Vzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776692322; x=1777297122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fYokICpGobc7HgSAURrBoqvAmQlrnvQorKBkQ8TZTxE=;
 b=tAJ3GlO/K3tzUuoLB4xHQoeZkdDYps4Jc7PqUNAHPpQYqnnEmvCdSMkbK2fHfmYFfd
 t+xFtGJfSAlQkE7ADmA1+oKKSv/7qS1XWE1N+fFURzo8seGHqQ8yr/g+8I6tunYYXD7F
 YAV2ED/RexG0e5NkL5evV/Lp+l9SY5ApaM1KISVUS2uMl5UUOAwaA9GcM2AK0M7wNMj8
 WDY5VJZXfBEIVPm4GI6ig4NCljyaG8mx8OlF5C/Of7y717oBG5FvM7APa30EMOF2QVLB
 3ebIB+6FON2s/Jy9MArIE4eazy8kY1ouQg/zCDPBEtI2gGCgtnmF4Xra2u/KQ0MZs1Nm
 PPmA==
X-Gm-Message-State: AOJu0YzzkP0lBG6WObrjng6Me8lQ9aP/+g8EH+uTnZO4OOdZx8Rj5yNP
 5bUcalw7eOAviMk0ehQmwjJz8rZrsbtIJ5uvCXE7jKyfUiKBpcZLG3rl4CzLsqUmVsrc3gEepo9
 bxK9zutswU/LmRyjq5EAGpQAdArrPtn9kte2TbG9++Cu3j0gDR1dNZ6TH3Q==
X-Gm-Gg: AeBDietENwOc29uNnaQ/nidAL/bfvG2oqw78J4bI9wmHipSqktCaW7VVPF37uEbsKec
 0KqmixI6R8AIM/b67/WpHA4tjVq0UuQRCyt0360ixk3VJkax8E5ULzQvr05WBvcHchW99vyTrnO
 L3tkp5DO8Pyik0kZ6k0q7JbXSWzsSXinVMJlbF/1nSd7r4T/TkzB7lfwyxwhfDL5eK8R2t6HDF+
 WRCtSvbXVX77160tvC1vCtqPv72Lat0qYe+qqmD8Ey62O46F999in6E6JH8PxRXY74SwuEUAbqr
 VG1BXo7R+r/dkCMt588BX6MxvL5pNpOdycPdC2f7ZnU0sSrlXlebRo4EjrWNbdfcCstxbJw5g1v
 WFGMUZcE6M0Au2cDGTZAXdP8zgI8xMOMuEqTEqPjdr6JP2gAg2Z/tLGngJd558/AwfhtGLbeYkA
 ES7wHBi2XuLAbOPJSUv/U=
X-Received: by 2002:a05:7300:6da1:b0:2e2:d94d:6188 with SMTP id
 5a478bee46e88-2e46538d9c4mr5994631eec.7.1776692321750; 
 Mon, 20 Apr 2026 06:38:41 -0700 (PDT)
X-Received: by 2002:a05:7300:6da1:b0:2e2:d94d:6188 with SMTP id
 5a478bee46e88-2e46538d9c4mr5994594eec.7.1776692321144; 
 Mon, 20 Apr 2026 06:38:41 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa5c38sm14020122eec.5.2026.04.20.06.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 06:38:40 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v5 1/9] hw/hexagon: Add globalreg model
Date: Mon, 20 Apr 2026 06:38:38 -0700
Message-Id: <20260420133838.1050234-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260416210305.2255579-2-brian.cain@oss.qualcomm.com>
References: <20260416210305.2255579-2-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEzMiBTYWx0ZWRfXzF6rB0L1RmhE
 lyk/qkuP+Lqs9cOJKO73ibDt12bY9zhqRqpGk6PTb4tLTY2IW5O3sR2QehGWHdv2yTcclJwlQcu
 ISKcTs5J41x3QvKWHR0Uwg9kZg/ASKg09oxUB3Gg5ERXw2GLrGo9cO3py5RJOkI+y9+2Tj2u1C5
 x+30LvCmWfThn4rSmO8NnmgiS13NBPhNfvCkTU1/R4k8Fi0mEeGu7x5nUW9bXkQtm0pp4KjWVTu
 3jFJvuVck3t1zALJ5PXUb3teSha9NpodQXnaEilkll1qNXvYpUVrPmH2lkyceUWDcCLq7CMHrph
 PftfZEOf3Gdwcq5QcBIXKCzbVq4LKYp+EeH4gVtE2ckui3dfNITNYeuxpKPt6zGrU6QL70cXS0p
 vqoRg2Cccp2JpYFFjHXB589wHASyYq9OOunaq5G+s+Ok1v78X5uAKbIjNUtJmyzjDDLIOr8JrZD
 +DSQMrS4a1ZrG3AIePg==
X-Proofpoint-ORIG-GUID: PjVEyMMDpKFtPvqsqdFmvzbPOR-NF1XN
X-Proofpoint-GUID: PjVEyMMDpKFtPvqsqdFmvzbPOR-NF1XN
X-Authority-Analysis: v=2.4 cv=L+ItheT8 c=1 sm=1 tr=0 ts=69e62c62 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=U25CkC4OY72ay66f1csA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200132
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On Thu, 16 Apr 2026 14:02:57 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> diff --git a/hw/hexagon/hexagon_globalreg.c b/hw/hexagon/hexagon_globalreg.c
> new file mode 100644
> index 00000000000..97e75a2f1ea
> --- /dev/null
> +++ b/hw/hexagon/hexagon_globalreg.c
>
> +static void hexagon_globalreg_init(Object *obj)
> +{
> +    HexagonGlobalRegState *s = HEXAGON_GLOBALREG(obj);
> +
> +    memset(s->regs, 0, sizeof(uint32_t) * NUM_SREGS);

nit: sizeof(s->regs) would be safer

> +void hexagon_globalreg_reset(HexagonGlobalRegState *s)
> +{
> +    do_hexagon_globalreg_reset(s);
> +}

Is the wrapper really needed? Should we perhaps inline
do_hexagon_globalreg_reset here, instead?

