Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10655606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f7PCJltB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NPRaaJRq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzRd-0003xv-Ib; Fri, 27 Nov 2026 12:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzRb-0003xa-Aa
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:09:07 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzRZ-0006rU-Mu
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:09:06 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFp3YR3328703
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +H/xfE97NggNycROBp/OvUvGFoRXCJdWUH7h17XEsjM=; b=f7PCJltBfUXVOohn
 xUJ/HmJHdQuGtCPuoOxDcMdDia8aBz2EfyjEybEMtxC0X/XYiT36x0PkhBmb6cJN
 zZ/iifrkxiCa3sTX6PCOkXY2lhf6n2mRYYDS/KzszfQ6GViDiXuA8vCl7VKTAO3O
 uksedunddL+WQqaBvLlN3kVSNnILQMxQYqghGKD3Nd2byxS6ed2rP6gYfBfjCBFy
 pRjy6I8MkdTYPO+nio+CVmRCC/DS0OQ4KTrN6g6TBFdGw9ogTwWIVDIPqIbL5H76
 Bb9fEDU/5rG0h7Vg+vX3gYuYqlphp+0iaa2jJL37IS/dvviHE1n63asIZ8+GsXiW
 ycMHZw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74ghaacn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:09:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3846d5f54c1so9045539eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795799343; x=1796404143; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+H/xfE97NggNycROBp/OvUvGFoRXCJdWUH7h17XEsjM=;
 b=NPRaaJRqBWyXgs4OboIoaCwpkG3Kz2WUhvZiJFe8N8giHwGeY7v69vdxU82roTsz5q
 VTaFWzZkknNy9+BNw8DNyyDQxgLHO3VUwtjoNourwW0UokBe16xass41w2cQwblQ3WEB
 toPaKApq/SJAq6WQ0/zM48eisHM/u9uoW8D2o8mXb+hknMDBNCBt60Vgfee8nK/YXI7O
 1oD5GorJ3/+ANDpUgLR/Tx2M0Y+n/hXs7RB4HXwxvLCT5sVz+wVtllPAOOTQPTTnjBhk
 OT6p5ZQSVlgRGecHJ371utO2l26hFNYD0tszPFSY44gf5KVXHpYUozj6Xjep2u9zY+bn
 6TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795799343; x=1796404143;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+H/xfE97NggNycROBp/OvUvGFoRXCJdWUH7h17XEsjM=;
 b=cMfaZDjlSxXUOIcb0mOTeZI7ab/UrXHtLunqh+RHoU7NHP++ZzsxwmHu9DEmgOvQer
 QNiyxfgZZuw+7p6dvt5RDuzDbLrvhFqA7P73QP878wLDAHuktVltb7YeQaaPwXSmDYCO
 5hdtUNuDMMEw0F9jQPYpFH+LtMoyVkoYNFDp8WywoTRpjf0ypVU48nFjwiUHc3oul1AG
 1UJScfCC861VMM0VmPH9upF2SmpsO5jUOTJmPM6TCEQUYnSjS2knT3aDS1CVHe0WBxlN
 QT0nf8/eqk0QkHh5Spw9rBfi4rFbKlQPT1w5pnCo1dBeR2R61VbgWUjXbL94YdsQQ1/q
 7hJQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFavE82mqEt9GVPSFpXLoZdJO5R3JCSYvhDmB6yOWdRQ7aryDQGYt4Bz71/5U44sNAe7B39e+O8+4t+@nongnu.org
X-Gm-Message-State: APuU4Z/s6Wd1munw1sbgHJhJEW5kvFMOCTsMFLAW4OiTt/SwvFpvqO+N
 FqzwcHVBLD4ms5fEwmKG1XKUHAfUehE2w7rvQ9i1bdUhEckkF9drabH5hbeIO+xbNphebWJ1VPY
 HrtQSprFBk7Qp3QyWX0i02RN/3H5GLY9sQC1cH2PCvVmqT6Yi9plIzNB/NA==
X-Gm-Gg: AZFdTZdzjTTznhWpd7L/+SoIuAU057GJfAWhQQEEXg643/k8jysdZ1Ru3BPWcio+L+j
 zr3Kuz92yfgNoP9iOWPZfQKtPycsInqf5dDI2j2Xkrr5CZM5jRHjgTdZ8nMh1rYsFV9yENwQnvi
 rLUyCSg9QA9iv840MG0wGVy6cJhH+UI/cEjXOxFX7kQINaSYSOOsloxGkubwm9+TkyZEJf51Sxi
 oFif7TlEzeUdhcMyxH+Nq999lGoxxi/QC2OVu837/7W7DunzCa4wcM7tR75Ti12xzBjmkvuYMZx
 dCsFjZIR7mroDOpKWevlmcxhAmJm5fa1TYCRzxl7ijMMQijdshkAJGQrR+ItFDjCRfBgGLnGEh2
 LDs2SUx6cPNuk7VrFuPKBwV4NfUjXk77HW8DInH04jUNM+UbhEDh7YcIcB07kpu3JhW+CLyYByj
 QuyPjjoCWHmUD8fpnPVjm5KEUcVzPE3wNt9pw14qLao5U=
X-Received: by 2002:a05:693c:8084:b0:36f:4981:da16 with SMTP id
 5a478bee46e88-3857073f5ebmr23442297eec.25.1795799342838; 
 Fri, 27 Nov 2026 09:09:02 -0800 (PST)
X-Received: by 2002:a05:693c:8084:b0:36f:4981:da16 with SMTP id
 5a478bee46e88-3857073f5ebmr23442276eec.25.1795799342241; 
 Fri, 27 Nov 2026 09:09:02 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672ce402sm70051550eec.16.2026.11.27.09.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:09:01 -0800 (PST)
Message-ID: <5cd3e56c-297e-469a-af18-b201bb99d032@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 09:09:00 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] accel/tcg: Factor icount_running_cpu() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261126222530.62175-1-philmd@oss.qualcomm.com>
 <20261126222530.62175-2-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261126222530.62175-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2OCBTYWx0ZWRfX/7yHRW4Pap+5
 JKbUwx2zuy6KD6bN4/4pZmdBx3lBzXqPxHM3YNKFhGFgdMbuVWrIIEvBS0vah0YyIThiymHUCHC
 nXHoWRenQLgVp30XPF69fzxBdA1foA0=
X-Proofpoint-GUID: AI8l_QsLAMe9mR3t8gA4jRZQoI40gUCx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2OCBTYWx0ZWRfX6gC40oivQnsn
 VU9fiztImJkdWdmJH+5x+hqJg9Nn1oUyaJz6hx6t5UuKwb0n8Bqu03zwpS0BQkXM1RCqN3sDbw1
 7Ck3uBJHcMEmfS5PmroJhY+X5AEiSlF13tNBbJtCJ+k+3rtjIhb3uyq7ghb4AAykYeyntNPw94k
 KBkEdVdLRnckN8gG1boSlerHxg5KdSbSryZ1AI0V5cRldleAb4UAfnjRcsrFWYRUmlFTJhYf9bn
 vIjTcYrVvA7YvGkW1lomrL6Zg/gSuY5acqHm4xazj0Gjn1ipKTLBKPeXgaXLb78f0kxNVhjIIjQ
 FM3FnGEIdzdzJxOllnzSe9hkxSZtE6k1/Q8cyzERwcmdqq3MU98KkvV8O+F6sBl0vI7dcd+zmmL
 zv9Rmapq0HT1m2SlLJry4iEWmUFjDTQMeTQ9dktQ//XcUsCWfszGkC38YhVk/7zRTqKU/mIDZ70
 UPtynWQ7dDU2TQWnyfg==
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09b92f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=NromAgFTz8thGiVjJsYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: AI8l_QsLAMe9mR3t8gA4jRZQoI40gUCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/2026 2:25 PM, Philippe Mathieu-Daudé wrote:
> Extract the running vCPU check from icount_get_raw_locked(),
> to reuse it in a following commit.
> 
> No functional change.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  accel/tcg/icount-common.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

