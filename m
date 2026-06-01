Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA27CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU8CR-0008Oe-3r; Mon, 01 Jun 2026 15:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8CP-0008OA-EI
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:21:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8CN-0005Qs-Tx
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:21:21 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651EPvfb4111113
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 19:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iHMNlpWS80HCxBR0Vpcw5p9YCngzuy4IlSoMw0rzjBs=; b=bEtgFdXg1ToX2jBd
 UzGeA1tvWyrdtboilA0tjpJ7Lkv0v6rppB7fPA0J83001Z6CdwAl5DZw3uxnWe0I
 N86UEyP6AMA1WkmjEuuPHfVI6bCDCzH0scyW342IZf2TDNctPG94w2N38UR64/zS
 f1N67MKdZoNYKjVyXmYrh56sMT2qfseoIbFZi3FFYdi8dvy0OGu0329jUK7KG73c
 JBoGIBYgCU6XaEusLmDiEvsIlLcKeDKGDxs0dVfd33j0SKwo2QtJQhElXYPqLK+G
 3ycsB7Y8BnzolH3YVuIOjHdOa8v995Co7xQhKS8mKmex17m5+As0pdLNX83205+n
 Lo9PVg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s3tnkd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 19:21:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304ed777a96so1946485eec.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780341677; x=1780946477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iHMNlpWS80HCxBR0Vpcw5p9YCngzuy4IlSoMw0rzjBs=;
 b=X/Vp/kVXs8NL7FK2d4fqzs82DYxNhX0K+80pRrk6K3mUjy8cTtEM9Jney3zJoapQL8
 lhZGsXigajw/CMzZ+DqkID/my53GGH6CX/Q+ISWLZDe2Y3Zn+4KAoITybHgOaLCi+tkm
 7kqOTX/xzt/evMh32P4k9so1E7F/k/arMDTMa6iG1l+Uv31riAIdJ0LP/i88UpHk9Fue
 EiJvHicSeVP4RUVGW1ViXO66tAFIovfEqP8mF9AZwMGwWwz7BuTloR0caoLD9eIZZe+e
 7fN/tQRUVQCd+00oCk6s3nPcx084eLd7SdJ7R+3zCcJlv/lYiH4gIbi1g1qBDBLnOLgl
 Qrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780341677; x=1780946477;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iHMNlpWS80HCxBR0Vpcw5p9YCngzuy4IlSoMw0rzjBs=;
 b=mX/YMHgfVNwG96LLW9NlCXRGk26CJRJ6yL2rUFDmJ6xs5gsCmt92dbbppuEZIME3fg
 d7WjRq/DfkzJFn03ZtZO5bpasPvq4WGmH8BTLIVwk5Rv+kLB3VPnhiOr9uGbeQDWv43t
 QaoQe/Fnowe8bsk6L6EZOkvlabzQUMmrcxZDTppVRKQHxF2WLum/bCa07C8wKXqzIgrT
 zZu9JdFzEuhZOQCNLFuzfopWLPXc86zuhZV2vvoPy/wSIH2B/y65q8vA+K+ZDuqJIjSm
 BDu1CfKlAQReZosPmLjh/oFzTMM3A57lhAB+/88a3EzHbVMGcteB4hJGlvRJugTiGjGH
 F45Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Fl0GuAnQuVqb3w54c9C+u+eS6ech3BSG3tD+jHaptCpQeH0rQriqBziNx/uOLWQ8WOMy/MPbNMq/S@nongnu.org
X-Gm-Message-State: AOJu0YxadnmUHUby7jkH2gZTQtbXEUFDj/0I2JYdJW1HekvVWDEYwgtY
 qFpO5WhneEAnEV9LmmPYX17eierirZyo5dsIfE0Rq4lXszdVgQQdcIXpZCpaa74cNQoezAVQ7gK
 yIwXcetWE9VyK/kEufc2Ba8in4S1wbjjpwS7++jElfUHdDl9LwPfTpBHm4w==
X-Gm-Gg: Acq92OHqDOC3HpSsfB+JB4IBMmGwiAoG1OhdAGM53PsmIVs2oFFAwHwED/58W0C+Nq4
 otINaCOEN2ckHua5L0JglkPzN6FEYwv6j0nja6xbjzd6eoOl854xiiO8kwtSvat9MSEYLlrqe87
 NUSQSd01xoPAuVGWFiBbQLVIzEZC9j+/HiBz32goW/Cf1Nop/bvm+VaVQr3M40IpYyOWlF2L8V3
 Q1mg2o5OIOWfPssEKji9rOBrEeO9s64D46Se+a3I6f3sNBMKZNHoqKEXrhM3zi7syvS80ys0E3M
 +Ejg5sjTasIY+dzok6qTm1DVcEuuifYi2tm6SjIyFBxqvHluED5V/NIcchPQHLKIoUK7Nw216G0
 /RyHdN86ycXSw/SB37jzNWTJTqTP+9LILMlSm4aPi368yindlnD9W5OetGTvf5cP79hPnsbOVh+
 SKUMxfl5I7rBoXFoCLsxYwzLJm
X-Received: by 2002:a05:7300:3b09:b0:2ee:7b2e:8a3e with SMTP id
 5a478bee46e88-30734a48b66mr413383eec.1.1780341676859; 
 Mon, 01 Jun 2026 12:21:16 -0700 (PDT)
X-Received: by 2002:a05:7300:3b09:b0:2ee:7b2e:8a3e with SMTP id
 5a478bee46e88-30734a48b66mr413367eec.1.1780341676259; 
 Mon, 01 Jun 2026 12:21:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed30a012sm10129635eec.10.2026.06.01.12.21.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 12:21:15 -0700 (PDT)
Message-ID: <703d10d4-a565-4585-93a0-d9e2c68b38a1@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 12:21:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/28] target/hexagon: Implement software interrupt
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>,
 Mike Lambert <mlambert@quicinc.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
 <20260529215806.608770-9-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529215806.608770-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AP3YypGC c=1 sm=1 tr=0 ts=6a1ddbad cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=cezCIfij1Mhy36_7YZMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE4OSBTYWx0ZWRfXyZ+VH7p7bWFi
 j83leD5ZXw8JzA7n6NqvPFEBJa9dABEaqk8qMRO6Y8NInB9QR771XCicopLX++Kar1e8q7/Rz+I
 7lQQeplA13WeG+x3E1pMDBsZfvN0GO1HN7oZonZjw2OyVxWX8paSpNtXRzFP0wif7NJD+dtCe7g
 hnj6WTV/HtI3vu6WIWFDrRr8lTSl7DOXWeyahoogIFTGcQSET5ptDAGsojnI5oDC7qJ4d4Q0qhO
 XEvk9nSjbao7MXk45qL2EkrbVMFviO/YDSqHX7HE1d6q+xqvsN0kNiThTQKHftYnqZR4KnBtXeT
 vyT8Q4x+Q2qmxN9TQL9RBYesx+8sNRfj+BnTg1dzFB4a1FiMx1SE88lkxc6JIWhodWsCjw3cHa3
 Hg5Ss7XSFMD9tAzmR8cdIsXKreRbr3G1atdGWaR2M1r7SbVmhasvofTnW4PHMP4vI4H0gajlW/o
 a/Q665uaQz0HizSMYMA==
X-Proofpoint-GUID: XpILYga69lbMdRWiEpkqFcUrp3LQNjIb
X-Proofpoint-ORIG-GUID: XpILYga69lbMdRWiEpkqFcUrp3LQNjIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010189
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

On 5/29/2026 2:57 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Co-authored-by: Mike Lambert <mlambert@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hexswi.h |  17 +++
>  target/hexagon/cpu.c    |   1 +
>  target/hexagon/hexswi.c | 270 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 288 insertions(+)
>  create mode 100644 target/hexagon/hexswi.h
>  create mode 100644 target/hexagon/hexswi.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

