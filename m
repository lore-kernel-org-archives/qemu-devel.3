Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FFEC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmrJ-0003fN-KI; Wed, 19 Aug 2026 16:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wwmrG-0003f8-Kt
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:25:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wwmrE-0008CY-O5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:25:58 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JHqaNM1011830
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MzMifqExjqo
 dkPnZsPuBA2asdyG92Uw+9ZmL2sYuyc8=; b=LlGf8KzuFOQtdaoRFa1rvBEOxVw
 3ecZjzjaLb28ve9uqQf3fKNGdysB5Eb7dcQrLnbDUqQdQQXAxWtISM1VNRk5bJV/
 FmDLZtg1v8vZk7t1fEWKVl+ofZ2mo/kXDYgPmN6VsF0c5KJ7s9QQE65f8F/D0XQI
 glDAkfHU/uleuGTz3xUY+iC+7vnvB4nouoyzKk+EBzE1FkF8Q5fL4fXbFnQ1ob1J
 1NQSVP5kCoq8Yis53YZ2I/ZxYhdNup5N5OQVtHxvKf70JRAqLADe82dDpzVjthqH
 nN08m0cKoZQH0F0i9tmUSfZk8JKsRwRnkV7eDnBbsIm4asLtmYpF2+kvF1w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5daa1y9p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:25:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so2763769a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787171152; x=1787775952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MzMifqExjqodkPnZsPuBA2asdyG92Uw+9ZmL2sYuyc8=;
 b=ZenVD/YTyFOdwCkEeG1eogGE+xoIZaOiZtgRm5yqDzKZygcOkP/H8DTEk1cpcZ10FQ
 meqFa/mUOBhaB8ElAp7RexIhSlvBBsktPW0rU/sYCkAr/65xB5+KSu/sl/msltw3H1I7
 BvWnPv6tTVewHUgxg3CgWGCy8uVISEbx6LWlTDINwAXzdQYgwGq0HDNoXzgvEsLnAkTe
 z9gsl06YB97t/5SDuzXBseI/UhoDk3dFTdRDJkiMwEizqsuQX/4kl1ntnnNdXxbvNRzc
 j+WYweWAN9eKcjfXpzzhZk+Qy+JpBWXlQ0YAgp7ufxxUuCh7lxgamo3Q44cOLEXiq1bF
 v51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787171152; x=1787775952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MzMifqExjqodkPnZsPuBA2asdyG92Uw+9ZmL2sYuyc8=;
 b=mrejF1qC7y2WOiEc1a/LxvBL7StLbHHGYibTl9h7QWDRZiCX++Av9q+I3/1LFOp3cc
 0Xdonj14r1nGpwTMJ5CfM7AauqhSCYrYzoqOjAPTPwMr2DQTczsvnV0ficnQfsy131ha
 l82XDU9MdFY7KKkqlh4JqXtyplCO17NjyrsIKdpdgo9JMl/BKtsemVEXKE4C899Csb1U
 hnTPeHwFskET/2Zb7U4n7wbjt+5SI23OmRUhd4gMp98ECr0uit0W585ZCu2yejS/jQvU
 UI1OVELKNgyk+Ing7WmtEAU18JM2f/frloL6QzRsjCJTydEqPIJii5juDQegBviNZGFo
 Syfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlI2h6ASzuL0ULf9S5hH/cJLcIBGCJxymZDZHM5rr4MHvR0R9pSNzPVu0hx3Dv40WJipUuMbi2iR52@nongnu.org
X-Gm-Message-State: AFuF++nFDWUPWokFyuwU3YO97PjDI2XQKwpZlmjEZc3/SZpY1+zotpbL
 dQqSJI0SaxUXw503VnBXCrfY8o0YwKXdTTXuZdKH50Y/1fketRZrvVEQ1PUfLhoClsaR9fl2yhm
 ScCw7Ci09NvM37FaL5a2cBdrwm5iW+Hq18nzO/k45wkNpQTqokulg71Uw5g==
X-Gm-Gg: AR+sD12upBCGyHNnXKdnW/OGYRqnzJgOSWjzGOotK8zBDVx+nuBF62IlbVKFeZEuOFf
 6zkUgUKPOn09lx60miXKCE7ErBrBfS2OejmWIqIRLrikJT+6P7Qpk6DPO/dK2g4eIDkW3FI3ARm
 osYCY/jFDcdfMROdK0psDSHWSC9ll+RO4FlGxm4woHvQOR+g0LfJ9gv+1qPFltj6gRd8kwuQ4cP
 PUhWkZ7fzgOSc5t3ML+wPbY8vFfbSk1Kx8c90wQzYwT8WoyOUJu347RlLxOLO981N7Hln4PBuXy
 xgy/V2goRnepgC6VOhmNxba3fjL1/f3WU5QaT4OQ7vgy8gfTZ2Zj5oPBgDDYRcdw4JazsC291BJ
 DqZW07VTvNag006xB7AObzzwaJW+TOd+26u2qC0FzAI1Wvo65OjBFRxYNMG39uBs=
X-Received: by 2002:a17:90a:d005:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-39580aa33d9mr13739759a91.5.1787171152226; 
 Wed, 19 Aug 2026 13:25:52 -0700 (PDT)
X-Received: by 2002:a17:90a:d005:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-39580aa33d9mr13739666a91.5.1787171151725; 
 Wed, 19 Aug 2026 13:25:51 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae89189sm9729066c88.14.2026.08.19.13.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 13:25:51 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: philmd@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
Subject: Re: [PATCH v3 13/13] tests/functional: Add hexagon semihosting
 systests
Date: Wed, 19 Aug 2026 13:25:48 -0700
Message-Id: <20260819202548.2090722-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <815d60b5-3bc1-4c4d-baaa-90df17a75f58@oss.qualcomm.com>
References: <815d60b5-3bc1-4c4d-baaa-90df17a75f58@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fv3sol4f c=1 sm=1 tr=0 ts=6a861150 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=dnJ9b09rcGLkOmvZeYoA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: xXnrOJbwfVAZeJ4zqGt2gM6S9amDOB97
X-Proofpoint-ORIG-GUID: xXnrOJbwfVAZeJ4zqGt2gM6S9amDOB97
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE1NyBTYWx0ZWRfX641KSBSLkP3I
 mE3heX4CLjYdpOw+eiPZ+523NFduowTIeQ1Pwd8Tzp30lUBCo5dh1Vw4fsUPNmDc7BpRSDrl8UD
 6S1kt583E/lKL5UCizGKi+mjGyumkzE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE1NyBTYWx0ZWRfX95v74yqbKVr2
 z448CHFidZPr5NYnlKSvY1ZsXwWjw9pL4Krr7kbnNeRxFPK0tnOMCjnAqy5hK/TAlNeduoL033r
 8ojcOzKObWKXlZ2Vj/SZl6Clz4GzZ/PI0KkINEfFP7eGsGAmklWiICzft4e0vRoklV9Aj8LL84D
 jvM05yP262uXeDt7mcgrLfittQvTyvQb4lAvytzzwbzHBI3/3UL+mDT1ysisR8noWeUc8Fb1n1u
 fN4rPMRNLwBzOUxC6yzpkK8vhnS0SDKpE0nxpXttu8IeZ3iUkHZuoftfr1Mk5PvA4/kgtqyzs0w
 MVle4rxhgQp9dO8fmKggFke8AumujftZos4IwYzRLCIeXEmt0fL9ps5qDENRwFnE4UiAQXyFyPs
 LoKrrIdmEEnpwzww/5Lgpq0FupKrRn1Wv/E6elhlhgGq/ZtMsWP9s2XVCwJlh3ibuGgD4N4Ur78
 0uxQWWpJjpcAoNWo9Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190157
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

On Mon, 17 Aug 2026 06:47:55 +0200 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com> wrote:
>
> Hi Matheus,
> 
> On 20/7/26 19:41, Matheus Tavares Bernardino wrote:
> > 
> > +    def run_console_pattern(self, binary_name, pattern, *extra_args,
> > +                            machine="V66G_1024"):
> > +        """Launch *binary_name* and wait for *pattern* on the semihosting console.
> > +
> > +        :param binary_name: name of the binary inside bin dir.
> > +        :param pattern: string pattern to wait for via wait_for_console_pattern.
> > +        :param extra_args: optional pairs of (flag, value) strings passed
> > +            to set_vm_arg(), e.g. ('-append', 'myarg').
> 
> Sorry, this is not useful, just noise making the review more painful.

Sorry about that. I took this from the downstream file we have and hadn't
given much attention to the function comments. You are right, I'll drop it.

[...]
> > +if __name__ = "__main__":
> > +    QemuSystemTest.main()
> 
> Did you run this test on a big-endian host? I'm suspicious about some
> guest to host conversions.

I hadn't no. But I did it now and indeed there are issues here (and elsewhere
in hexagon emulation) that makes big-endian fail. I'll fix those for v4.

