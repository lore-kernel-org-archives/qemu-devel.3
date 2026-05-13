Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8BDCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBth-0006SV-1T; Wed, 13 May 2026 11:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNBtb-0006Rt-Ad
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:53:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNBtZ-00034N-V2
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:53:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DF0C0A3474958
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 15:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RVe0lpyi6iSoqUbSaY65niuqkgqVoYagozq75N8SA4w=; b=ST6FRMU29Y12I36N
 BXqkbQhEQaQQNKAu5Ev029YGIubc7m/P1v8d7WuFS/DPfvEEtbCvjt5zU24Bez5S
 Qj1y/kiXOTLlQLfhsmF6lTSvbgl414mogprg3Wv0NF0VeKb/3fy6G4d5K/4wmQlN
 x8Q/Dmm5m+TxXHdpmtyyCPlTHmQXRULwRDLkxdGW0/FPkVIxB0k8TWljFDU249Jx
 3B0mGkBKZFmiq2nnWyAv5r7uNZhKKS4dJqWwXHTCSeWBsJVSRHwgshvMia4BnFGh
 GHkwve9kt9+cex2FuPG6jdxL4yIQi75Jn0xqdo2RrLxrF1aOAJDUClkWN1TKxFBI
 26fZHg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p419nv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 15:53:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso6717887eec.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778687592; x=1779292392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RVe0lpyi6iSoqUbSaY65niuqkgqVoYagozq75N8SA4w=;
 b=eL1dAYWk/Ocwy5zylwuM5mO3BWY/E9rFYqZ70RLuIyqCnFFXiaxSiTTOaNFnW2X/e1
 A3Z5/pIiCVjlgB6fSrcxZTQPnIiRmbcM8toPfDfJEZrILcxSky75C30bwJgBLX+NPWvh
 TQO0Ya8pHO1ihbteV3M9H+LYtI58aI3msWQPLGFpX3/zHr/iO1CzfBAUaC4OjJYUlKMn
 YnMqoI6A4ZYVzx3+U5aB2vxDShFjyVVwB80Wu3jr4m2rF3cqDxBNtHvzi4kl8WeQs8up
 2AkNAVVuS6+VOoWYdpbHU8DwdbARjb+fsgW9Kvfp2f8N7//OCMYJRjIx2cjQrf9GUGGk
 Zosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778687592; x=1779292392;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RVe0lpyi6iSoqUbSaY65niuqkgqVoYagozq75N8SA4w=;
 b=VD/LuZmSrRqwqAvkGFQD/k3ur+VQB7LEqJZ28cHPSpyl99MyOsX54xk3h5H3zHyWGJ
 IEX6eQwOQlkzLXAy5aINTG1QgHdKZGGNbW4a/zKmWhIbyT4KDeauaU+hdqNAa2DQ2k0X
 QwxCV+uaJfQtOrtFMbakUR6VjbZK44gVSkt4a0Kc2uNMrvP6tbZ4N3QNUzEauI2LYLWt
 T/nSzBJgBIgXaomvy8dZ9j7xHwlv+GA524aeccWFyl7Ehamd4/UKE8lNpbh+ZBZkje+T
 jFs+8BpTOwRuqRXEHah8Eeo2tWIMbFHQCPoF3w367rWo+Ndz0ud+UR+dSnrZzNDDDeaj
 jrww==
X-Gm-Message-State: AOJu0YxOAWEAp8IE335E5NkgIfCvoOtI+DfDTmuvDflhuQ01ECU3GsVi
 xg3JXUzTFg5OecCPk5ugcpyQydFEyHiSAeOqhGTAC7x0uCkTW3SutkeVzKQBjJfraD3BZHTuSGO
 JFF9xzPfCb9XGmBDkxwIo20HwgB7+de0//j0doEFA8Rz8cI7Up7tVnUpeHA==
X-Gm-Gg: Acq92OF/31353G3aDYRNzQuSQ62d0BsssBCazJx9BAJz+bnmHujePT3fa54cg7x96cP
 zz2xNzJG/tp2IafUiY8IKZe/XWUZBDaWJuvdIYMDREG2Sl5oJidXjXaSfY0h6So4Dwc0ay7QsDW
 un6LgaFGDF3xNQum1VBSxaD5Xy/WYRwhnX8oaHHtKeBf4xidywhbHzfpWj9FmOIzto8/M6mwWz+
 wo7wQKQPQwEmhT5DUkoxSsuXIbWzjO3M1egLsEdqYMNV2fXvhfKadHm8Gn9Idi4dWvxG5yXVaSi
 sCzImud7iPsqQXtPSyYFmvFX/MJhXANk9sgaaZfmM9Rk1pAqGhUN2anM6lGMl03TIloayDbzdot
 HBgOIdt/xuwuJ1ARVbC8ZVLwOZ5u5jLqUTbK+pYMVHZt8SLYVdafNMJ+it2y7g2sZ1y8oxM9W9U
 4ieMrY1smmx/IzDg==
X-Received: by 2002:a05:7301:1698:b0:2ed:e12:376c with SMTP id
 5a478bee46e88-3011a4685d3mr2227596eec.34.1778687591625; 
 Wed, 13 May 2026 08:53:11 -0700 (PDT)
X-Received: by 2002:a05:7301:1698:b0:2ed:e12:376c with SMTP id
 5a478bee46e88-3011a4685d3mr2227577eec.34.1778687591135; 
 Wed, 13 May 2026 08:53:11 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859e8389sm22814543eec.3.2026.05.13.08.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 08:53:10 -0700 (PDT)
Message-ID: <60a06125-90bd-46b9-8153-1dd36fae1937@oss.qualcomm.com>
Date: Wed, 13 May 2026 08:53:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] tests: add QEMU_TEST_IO_SKIP for skipping I/O tests
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-15-berrange@redhat.com>
 <fa8be3d8-6d76-4811-83ab-69c256e8e44f@oss.qualcomm.com>
 <agNPkLRe0Rf4NYcU@redhat.com>
 <cc8714c3-143d-4f63-a608-d301e8ba023b@oss.qualcomm.com>
 <agNXCf5eXNQmhCAV@redhat.com>
 <799539ec-2a91-49d8-9ba9-15d536462576@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <799539ec-2a91-49d8-9ba9-15d536462576@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a049e68 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=kdprthhZHocHlSNRw4EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2MiBTYWx0ZWRfXy8LKzv2QUvFX
 fRe+amMtgNlWkpx5/l2Yjn8y6bYwkyruXLnwkMQObLCkQxWsUBl2VdEFCvAKYWDflO6JNXpmbs7
 zwclcKUuatKmFqsQnsm39shH9Wc8p1/agxLCSIJkzjHa7aTXoew27qogvELgGKRXLBN4WwMWikC
 PniiZiU5n6GPyU+2ggT0fBspEXa1YCLl8szsAWwCwRPoXuLWkG4shKvF9WhuX5AU+Tyh36Fv3XX
 l3yvWh7vyBwRvbqrhhno7xVu71k84usBm3+Z92KNlTF8Di3hbYAczPOdwVSmJoKoYRzsw1esura
 N9zrvhEG1o2/XZuKw5x8TzdAOMrdQiOJEp8pQwOjN3WBvjOrQsOkLGm1JKrM5jlN/jOMxxp/Ghp
 x7Vq8SUJEM7jfIgo47DHhbUTh4Bu6TMvjkqL6gsbw739x4kOLkZKUi40iZ36LwPGdxYCCtkwRrX
 zdxrlqxHA9avHPx0Nlw==
X-Proofpoint-GUID: GnsEEQUif59sWNHMhzHHWded6_qP3ukb
X-Proofpoint-ORIG-GUID: GnsEEQUif59sWNHMhzHHWded6_qP3ukb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130162
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/12/2026 11:18 PM, Thomas Huth wrote:
> On 12/05/2026 18.36, Daniel P. Berrangé wrote:
> ...
>> IMHO there needs to be a way to skip flaky tests which does not
>> require code changes as the only available option. Code changes
>> are the permanent fix, env var is the immediate workaround.
> 
> The functional tests and the qtests both already use the
> QEMU_TEST_FLAKY_TESTS environment variable to decide whether to run a
> flaky test or not. Could we please use the same mechanism in the
> iotests, too? ... I'd really like to avoid that we have to remember
> specific ways to disable flaky tests for each test subsystem...
>

This sounds like a good idea to reuse the same mechanism.
And should be easy to implement this is in iotest shell script directly.

>  Thanks,
>   Thomas
> 


