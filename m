Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE64CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 20:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDp4A-0001si-Qp; Mon, 05 Oct 2026 16:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDp4A-0001sY-62
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 16:13:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDp48-00045P-Gi
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 16:13:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HKegj3579387
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 20:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RtYoLoUyKBlQKbzwc5eTsYae842MZq6+NyZnnQ+BpRY=; b=A39Nvw09Ff3iC+gp
 wUa83V+ojx1DlucHsL/YTh9Slslls64XhQTCYriGr1jb8OkcA+HRdq/IABBFclJz
 qkyvYoni6wKK8DkBLLots3dYcBo93PrUxK69QYHNP7SQMwyyyMq9VHZLqclrG6aZ
 SewjUh1OwjW8Cx5jeBSDlDi+zAp3wQoOgbGXYdDt+EJ+jcMmdCDs2LkhRwRM3CvZ
 QrMZo+9Z7m67XwlRWhmvDl61T0+sZcfFvMZaInuSo5woT9b3KwgPrI6UXa0mb83Y
 unjyZ9UC4Z3xN8Lquh9bveDT7H52OmQfofJYT1CbYITaXvxknEL2nGnNEm0esqLK
 bGZMAA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cuu1huw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 20:13:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5337f26ee19so60881181cf.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791231217; x=1791836017; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RtYoLoUyKBlQKbzwc5eTsYae842MZq6+NyZnnQ+BpRY=;
 b=Aye9lhhO3NAEKwqd/4A4ivjx0ts/ynHSMuL8TNyxCb7PN3fK4IuwXqBfC0pH5Eneo9
 ygnNNxkAbaQTbp9dzGGsVexYqAY+oNrXZvIndIqDo9nkcP4/HNVuMlFOO34K1h9svAZC
 nRlVDw25Dh0xxijrM7SF11QtwRYA80lx4C3RFhej7KD8DbsJssha6r97kGecfMxRs3rO
 3hAQFejGSV/9cA3g6KA4q5RJdKnAxZigpkZ5lDkZ/JQX9YHduIC3A68IezXZbsL1D0oF
 My7ScWbJsUmx9msFT/0lxEjYvaEsqhhNpy0JqU+JhM45tkCOWn4BBf1DCfuHn9ZnRHSM
 vIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231217; x=1791836017;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RtYoLoUyKBlQKbzwc5eTsYae842MZq6+NyZnnQ+BpRY=;
 b=u06iR8gNN+Ou4KIAzaXcNvh8GpmF80pa+klZYCit/23BUwdoukYVHkAWg4tjmWh0Rf
 bcPk6nar+3STzFikQWCcskB3Dow4dFHgazcePAMrqh3s4RKC4T1yHG++DU9TLcHn9Xv/
 DhvnBE8ZCBJhAlJsbD0+5vFtZc83QJTk9U46wTSUwfIO0yEgHzjpEk3yIew8PHqDxPSI
 S/vD8WQ2HLhKhLLxHI/kWU4X2zxGOeDWDoFm+zt1O2C1lxrCsxR+GWAb1gAo+Rc8Xhj+
 FKQiP1zrtDIot+nwUU+k7YTRpYc0erGTQblD+D7UG40ay+aa/1V5fuDtWioS6wtHL2BN
 4UbA==
X-Gm-Message-State: AFuF++mLPBPCsE04Phjt3lF7F9CVm4zI6DkQfRELD/2+BkwFFvWEW8ys
 mh90HYswuSpxBGq3kW+EzX5Y9jHUnWCeogiMba7W5TqHwh5DiiPbAwAbzl8bXs3LmARqz3guyCC
 7b0Xz4eCvkwNWfLfLoW0W0lg9Z6SYL0UCUxaA1M4pnc9d3nWm0x0LmCCdgU9ilpcVGg==
X-Gm-Gg: AYBFou3RgURORrW5jOIVnY53HCbG4fdy5+upmrXTHu+Duz/May4r0knk8ciXSIdfYnY
 SHodDE1sXgUOro0pGQI2zWLnC1881iR+asJ5wzDk/Alak+SvCHT98s4ch0vcXXOoI+gR31J8F67
 6rE7UAzzLcPAYVDIY/4CGjo5QP+ZeI82Sf2XuN8g/6Hk9/KNy6exc2nJHycpCtGEZ0spuyUtELO
 2jdgFehYiiUfv63J+qAZTizLym5TdYf0p+fVXr5k8VD363i5FSK6EAt6pLN3l9cAt6FVrHKWINT
 lyy3YlT0NbBm2/EYXP0oDNhfQwJfgPgepPlW+og7U76cH6zDuaNDOvznyANJFZL5XZO9BG1rPee
 tXkyjjdt4GXo2xe9qMh0VDvQNxj8ZLfBxZ9JDU3bPfNLmv4pPKPCPjuH6j2HC
X-Received: by 2002:a05:622a:4cc:b0:533:2717:6221 with SMTP id
 d75a77b69052e-533d9572b58mr219041661cf.31.1791231217122; 
 Mon, 05 Oct 2026 13:13:37 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc:b0:533:2717:6221 with SMTP id
 d75a77b69052e-533d9572b58mr219041201cf.31.1791231216654; 
 Mon, 05 Oct 2026 13:13:36 -0700 (PDT)
Received: from [10.248.104.162] (129.sub-174-237-82.myvzw.com.
 [174.237.82.129]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0c14c97sm95145796d6.42.2026.10.05.13.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:13:35 -0700 (PDT)
Message-ID: <2e1252e2-ee1b-4945-a353-c4e8c208cc51@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 15:13:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Hexagon: implement nmi, pause
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261005194519.2945862-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261005194519.2945862-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3OSBTYWx0ZWRfX62bIUG0yEDiU
 Sc6V1ha8iLR8FoQo5rPlT/X130faaOM8zZ11ZpLtGUS6uwXHfKqP8mukNuysHwDBKGSyNO/OEuW
 FL4UiqKf2Pub+NeYxxU450ae9m/NRss=
X-Authority-Analysis: v=2.4 cv=aKRlOr9m c=1 sm=1 tr=0 ts=6ac404f2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=acjI/O1q69M/dhd/NZk72Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Bnncx7Mllocx9Xdee3UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: e65jXA-lxTurrml2jW9FzDPsYj2yFzWb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3OSBTYWx0ZWRfXzdxjwA0BS3bW
 nlQ9REFyIcSPwnYuqxOMf9M29XVNH85I1pTc2fQ8FPvb2xTbYudLLmSMS/XXDnRt/joUNWWW2+x
 cDlY0SYVtycHDaWqaBHC7jYcCKS3cu+XOQP+q+PAwW9vYIqT10BLcqBTGUOn92jbMQGsnAlBXuj
 ggG88ZGXzF6aQyXuU+TEOCUPjMqo5nnK0sQuyuJflFFjYSkKXHpB0vZ9vJDQbx2Kw5XCt9SK1I4
 rH6oQjn2O3kylY83Mmt7CwYAFZKTtaBzRt0ZHtVx4vfeXZfSyE9Ch2pen0E7oX0VEBjflnb5RXe
 +v9nbN/+Og5NMcGsijKIEXu0Tp366JI1JSgWHz6lrwtVpO3FBaJeHLNamSWZ/Kt/4613CEQsAWP
 1S/1yIxaw2wlV8NwDCegeGOzwymgNnV8xsYn4BZxTot+5g4HzxQXHzk1CscVTYzoKtsw/OnC/Rx
 cjRO7SwHdKNnpgpYXzg==
X-Proofpoint-GUID: e65jXA-lxTurrml2jW9FzDPsYj2yFzWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 10/5/2026 2:45 PM, Brian Cain wrote:
> nmi and pause instructions were nops.  Now nmi raises interrupts on all of
> the enabled CPUs and pause raises an EXCP_YIELD.

Whoops - didn't take enough time to write this message clearly:

     all of the enabled CPUs ... in the nmi mask operand.

>
> Brian Cain (2):
>    target/hexagon: yield on system-mode pause
>    target/hexagon: implement nmi
>
>   target/hexagon/cpu.h        |  1 +
>   target/hexagon/cpu_helper.h |  1 +
>   target/hexagon/gen_tcg.h    | 10 ++++++++++
>   target/hexagon/sys_macros.h |  3 +--
>   target/hexagon/cpu.c        | 11 ++++++++++-
>   target/hexagon/cpu_helper.c | 17 +++++++++++++++++
>   6 files changed, 40 insertions(+), 3 deletions(-)
>

