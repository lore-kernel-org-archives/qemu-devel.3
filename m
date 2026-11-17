Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB389606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XmzUvsWk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XNkT2nEF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOTW-00067a-3o; Tue, 17 Nov 2026 14:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOTU-00067G-Fs
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:04:12 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOTS-0007NY-0H
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:04:12 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQeLa1916197
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 19:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=OJz0xo08RMpxgKaeuIhDiqsj
 AmztsPne/U8NjLIunFA=; b=XmzUvsWkpMA9GuZZAUb2GH9HBaMsG0f+PNHGsOnC
 i81+9BwFxu1invHV4i74R8XWbzG5K3rObNAqJP56zpavK/pXUZ9ZifA8bE//DUoA
 PYMNEgj4YuP4+kv+/XTIBvv1QRMQOVDkwUNWy2qYUDdwinL/K0uO+7RiwHef9Sx1
 gjcrh0yAzVzY0EoAnV4NDoL85P7cczXf99Ce/A8O6PjK24vzW8dvtHWJ6UZbcMFp
 Khnt/H60yOFJa/2hnqsHrDx8QAwNFapgFaRkuM1C61DD927HpVFGCUaUF6kk6eH0
 Pi9VsRv/7OzUel2CRhQfZQwx/Po99+nH/FNygstKFMmu3g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0nc827gk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 19:04:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-921052e3e92so454826d6.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794942247; x=1795547047; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OJz0xo08RMpxgKaeuIhDiqsjAmztsPne/U8NjLIunFA=;
 b=XNkT2nEFoJ1miaTc+N87A5Fj/b6qLNymu/0hpp2B2TTia+B7Cuhr5JPCl2uTLlQeJG
 5oOZtdnVmW7CMXIQY6TzSkqtb97/mhXILMnzuay6pQSZnAQ6noKwXAjfshb8gEzg/bF3
 R2J0dSMCahLPeiyAPWnDAmNIa9L3JKLUT+N2yaQHpkKkLqn8HuNBD/ZqbwCgvfGqmNev
 SQiXnNPGmDq03f+ycNT4oxmOqUpk3Rz+WIKa6kqoFXZUNVyh67zU7oDyXXMo2E/NVpMX
 T8HAcPfyWRfw5Ubpf80lxVn4F2ovowKwrCAWUIT0w0r3GO/h4030IRHf4kL/19vpsngQ
 4wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942247; x=1795547047;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OJz0xo08RMpxgKaeuIhDiqsjAmztsPne/U8NjLIunFA=;
 b=wE5gUpPD2zZxeqp/EeM+wX/7IFha8HXU8JMUnWdTHaURRsmP4z37/2LLYmGH6sglV5
 /mym5uVQvzEes9F58knjppW00KVL9sAXImqGc59smtyTv7dqS3uJa2ByLV4/6REZvPmf
 3VBSc4xnPXEk0En6ykMnG872yb+tDPXxuVoq5kQ5AYosBxwLhxWbKS62s53kkWca5KWE
 /Z24Hg4HDulzoFhIfBTTMUOgBtme+1BzkzBI6jVNSE6H83q6qJ2fge9Q14WPODP85H/w
 OmW4L9BFFhlC9IbRnfA3WCGkXRWkZ5HRpIJtlRrL/8kUt/ac/Z12L5pg0cqbAJvyQjG5
 40vw==
X-Forwarded-Encrypted: i=1;
 AL+hErExrJDyL/KNMGowaG+aChfDovfV5sw6i8l9k2rSsy9QFFQHBNUgXOaPwnmTQxDWHflAh6Xx2Ml1drZO@nongnu.org
X-Gm-Message-State: APuU4Z8ETB15dVnpq+OC7IAhTu3HP7Y1K/RvIQGpjvnhrSpUsHnbQReZ
 dosD8oqnPxgxBOygJA7Z7cENbWhhmZhsyTG/sJTHkHP/Ex+QkE66CXB0RbVztguOhi4JPRIOghi
 BTc16KfXnLBCEdftEKMAHIe2LT+VQIakq2ZLoK13wld0OO3oA5q+LvDRrFA==
X-Gm-Gg: AZFdTZfrP4mEBejhmY8Bui5MmdXMcf0VHLjaPruteYNI02YP5nOddOXR4DLeU5akJol
 rg67eZlyj7kBUy6X7dEO17bq81Yk6eVEk2Y/rCoCvBecDOiX2yU1LkAVjRvhkKXAPV63/AvC41K
 ilHNf8ecgBQPimcR3mftp+aqbR8Wq528rO8AxER/0SmJe+5mFAVMsGYAYUSWtrSfuU35cQbmpld
 +HLxbHKSt5t1oQ1CAQaevPiHpERElwMiSo7WJD5qHj3C+t0M8yjxcRieeZSk4oGr7oVJWJl5i/b
 P4JW9vPicug7D5VFSeXEZVkMztcMlOKGXynzcEWTRBnCN1oqnKi4QBhQHNXdRVWcIL59NB1AG0p
 pmJe7zr1pZu1kwPu0mTjtF0rYGr+vCBGlEWfSRFEqA2faDNGGWuULoy0ogohS/DAn59qi5YP2vP
 IOkJVdomthF84fJdZUszZmAhwwXW5+shu36h+DpA==
X-Received: by 2002:a05:6214:1c0b:b0:91f:1498:4e2b with SMTP id
 6a1803df08f44-92114dc90abmr1956096d6.9.1794942246902; 
 Tue, 17 Nov 2026 11:04:06 -0800 (PST)
X-Received: by 2002:a05:6214:1c0b:b0:91f:1498:4e2b with SMTP id
 6a1803df08f44-92114dc90abmr1955346d6.9.1794942246355; 
 Tue, 17 Nov 2026 11:04:06 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92114dbef06sm816026d6.45.2026.11.17.11.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:04:05 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------rZLLbMI5m0Ygffd06Jktb00E"
Message-ID: <01ab9fca-5bc7-47bd-96ac-97cbac739e94@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 13:04:04 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] target/hexagon: distinguish packet-page instruction
 TLB misses
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-7-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261117183629.2002840-7-marco.liebel@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=LaipeTfi c=1 sm=1 tr=0 ts=6afca527 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=Y1NePytOHucoCMjDTT0A:9 a=QEXdDO2ut3YA:10
 a=9WBUS0BUyEarGz7gnyEA:9 a=OdRElRcbYItEDeqh:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfX2xxD3QGy4CTz
 cyYKSx/8NMby5Xmalgm34WDeTEKcUZ2x6MthCQih+0R8p1kmJvS/rceny6Q15RaW11ltteeJp67
 hTF6qiAMMawhuD5spwKVF/LL41g3m0M=
X-Proofpoint-GUID: -9z6bLc2OvYWUcXk3DDBwuxtKJ_sH9U4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfXy7K+URyzhO/M
 J1UT4rJMWLbKPhEfSIYMgCCZkxd3c9VOgKHtcAKH72Uc0ZldxR8DIc10e6RUOAhAUgNnSq8NFzV
 txBYG0002TG0tKpVYnfGXStqVvtGrHp6G72YAp00LM0xqi0Vc6264uYs23tTaIQC/t7feLkX7U0
 H03P2K7WnGzTrGwMHkU87KCxDF3P+fJ4bF1d3UEax82BciWT18vBPC2f1gWcPj0bhgmThOyWx5i
 2YeT/Wiuuzq4gKu5nJIQATzghusdvvpxS92VNtPI5r46hK7CxycRv7MorvyUAqddzOFK+TJxXFm
 ByvTPramo9TWoDndEfbvFmYXC9UC7tWjo0HrBEPYD7txhqgz993dDkfdzjtmd89GCntWPJYR4BZ
 0WbMKIi7Rds2IJTcwxf2H0vrUZgQhjkJhpoi0+kBK4KS5t927XXj2ztqy2eE56pVyQLzQtP+JS3
 qdp5o4aSQ1LMA3nxEsg==
X-Proofpoint-ORIG-GUID: -9z6bLc2OvYWUcXk3DDBwuxtKJ_sH9U4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------rZLLbMI5m0Ygffd06Jktb00E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/17/2026 12:36 PM, Marco Liebel wrote:
> A page-aligned fault address does not imply a straddling packet.
> Compare its page with the packet PC page to select cause 0x60 or 0x61.
>
> Signed-off-by: Marco Liebel<marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

--------------rZLLbMI5m0Ygffd06Jktb00E
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/17/2026 12:36 PM, Marco Liebel
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20261117183629.2002840-7-marco.liebel@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">A page-aligned fault address does not imply a straddling packet.
Compare its page with the packet PC page to select cause 0x60 or 0x61.

Signed-off-by: Marco Liebel <a class="moz-txt-link-rfc2396E" href="mailto:marco.liebel@oss.qualcomm.com">&lt;marco.liebel@oss.qualcomm.com&gt;</a>
---
 target/hexagon/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)</pre>
    </blockquote>
    <p><br>
    </p>
    <pre wrap="" class="moz-quote-pre"><span
    style="padding: 0px; tab-size: 8;"
    class="hljs diff colorediffs language-diff"><span
    class="hljs-comment">Reviewed-by: Brian Cain <a class="moz-txt-link-rfc2396E" href="mailto:brian.cain@oss.qualcomm.com">&lt;brian.cain@oss.qualcomm.com&gt;</a></span></span></pre>
  </body>
</html>

--------------rZLLbMI5m0Ygffd06Jktb00E--

