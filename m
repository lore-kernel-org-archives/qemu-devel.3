Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B50606A328
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gNb3gh2N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FWeKnml7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPEyp-0004ue-1y; Fri, 06 Nov 2026 03:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPEyn-0004uM-3K
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:07:21 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPEyl-0005yL-CN
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:07:20 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RIJA1679452
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 08:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hDVsnN4YMXeww7pXRrokJodz+DxEZIqV/B7lvbTJs+Y=; b=gNb3gh2N1TEA+itW
 OBDItKL4uf+24qmYO6KJNjGG/PKDzfNZvKtjC+1ZzMdVTbXs8RUAism21d+nF24l
 up7j6dHc6n1NBAfAHcdVcV7tT3u7epI9C/wZ2s8ICOUrtPZOxlkWhtxkLSL6wQ0u
 bP+e5tLdMRnWV6L7c+RNi+IAy8ECnqgxq/xGoxnryyFlgTj+W5Afs0UF8zKp9Wta
 IwuPetGdQDfTRc2X75s1qgwA80td/qzJuXlBQ4GelunvrmP3wRDuENgx2I3BzPtz
 hAlxIJi2bk0ZyE5y+fUSh5bZKaem88MUPB1Z6B3kO8cacIwbJNpeNnypMlb1w8Ja
 P+RfRQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pc9rmb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 08:07:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b08aee6b3eso431429a91.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 00:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793952436; x=1794557236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hDVsnN4YMXeww7pXRrokJodz+DxEZIqV/B7lvbTJs+Y=;
 b=FWeKnml7PrMtxBkzh/exhByez7djCQNNfzYC1DsSAVOV/B55GCyoXIQmknn2FiDmQq
 JBmPKxQBgt+mB2DCWOSydyQoV0zkKDW46H6cIfGOr/Fjc7b+WkQxgUeWdJNxTEei4xbK
 2aWQGY26FFhpKwhg7Kk1DRgW1wgMpErJNb3WZZiOixJmo4x1IXckbVlQ1kElrU9RVmmw
 dScibrdVU4nQsLfXSmVCvWMRU4VKKEBMhzAN767Hb59H+5UEXMPrJUH1sac6ZC4pLmYA
 W/Q9C08uFl8v/ca9exm66fW2gHSDTOa5zgIJlfh0fY5ensT/FnIiA83bceZE3p1tT1jC
 qkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793952436; x=1794557236;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hDVsnN4YMXeww7pXRrokJodz+DxEZIqV/B7lvbTJs+Y=;
 b=pGjdtihO8V/vBA856RODio07IUwhMxiPRAKygtRjo2jMmKXTnQiwctEWjaX4YKgvSV
 CWYOoNZ1XkcTLp1KASGpGoIK8VfFgqhiTs8kfmariGimxCkNuad3Zh5o/iwoyPXNQ7JB
 dxlegrI/0VC9gUSVlWI9QSJ/a1OYt9Xyjnr9U6K/aqGUs201HL/TcT+owhyWDiq3nrES
 0XDNkrFQPakqVyo/WBTO1eLR+iV7uRlFD6D2jfk4WzZLPxrozH/KzAbHn5yKaxJtEm14
 HE8To+jGseA8PZ6Z+hlr7HEaCYcXNbHsV6jMVqZAiOg5xjmGXF7N0Go7MjbXaRUPfBDy
 5RLw==
X-Gm-Message-State: APuU4Z+LHlQ6mbO4he/HTb7JScXCmHD05WvvDpp8CW2yfhAeYG3a54wR
 ZOqteUbKqI3YzWW1JbyKXKN/7Y3RgK5mP8UnieXEINJJ3TTNP9EFkCMiKLbHPrYaI2CG8pKeb9E
 Jlg/9AsRuhMh553y5PoapuDKfKKMIg9e1z9cE783cBsqGiKmcLwK+wK/kig==
X-Gm-Gg: AYBFou1biQ/7LVa0EASEv0QMohX4/cieWuCrtnbJqmPSIo93zvf4eUzCk9YxTEVV4mi
 GGeRX226ENOpjXhLlYREN7K03WYhy3ekurjfqTsjQse2DeUqhBdY+nc7OFkqAAozKg6Kihd+TSp
 zO+1Y7EKSZeKz7ynl/z+SZswNdt4CD9YWtz4VvBMzBDU0982SA9xN1rFIs1kVPBukeUEC4zUTHT
 4+SWKH9wzS9KhCJo5/qyWzB/0N1Np/lczTJ9fRAF7icoJyUmupnKwsUe1V1Z5m+hePhWr6E27fO
 bXRucTvVHdKqOYs8hKKphCro8M49iRxCk9EgAPjACrwD0/ExTYUVxY3MsKs1u76gUmaAaz2+lLB
 9ykidpx9c6Cu2xFJKtg+XWYgV2GgjgjB2L5SEw0hYNmZfeuZhztFBlxF9sFmB5YL+48vS+n/Vr/
 CetO7ZnkRGLGLSq9P5VhopkIyCTODb
X-Received: by 2002:a17:90b:540f:b0:3ac:80dc:f40c with SMTP id
 98e67ed59e1d1-3b0db6d7586mr1726205a91.14.1793952435950; 
 Fri, 06 Nov 2026 00:07:15 -0800 (PST)
X-Received: by 2002:a17:90b:540f:b0:3ac:80dc:f40c with SMTP id
 98e67ed59e1d1-3b0db6d7586mr1726185a91.14.1793952435437; 
 Fri, 06 Nov 2026 00:07:15 -0800 (PST)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0d7c42932sm2340212a91.6.2026.11.06.00.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 00:07:14 -0800 (PST)
Message-ID: <2bb23d49-3d2c-498f-a191-5a64fa8b3c25@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 01:07:14 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/lcitool: Switch to a newer version of netmap and
 check it out faster
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20261106063103.21061-1-thuth@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261106063103.21061-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hv4qh1HhQNvPlwwtdU5aA8LsAzN9Ejd3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzMiBTYWx0ZWRfX7h+7hz5CXvHl
 YgO4FK5y+S8yWBR5Dzg6xxjI7zDLbMbTz26CzhxeoO28GChWU3/Q6FKs7pAxq1Nbl1V5KrVxOuh
 QPO/alTMsOtvOFYt4jDuGR4Zv3CUoTU5rclOoOsa97Y9Y/Qeoe2bDBr57lePhEr2kZ4h1t8KQ2Z
 1hXhrmK58i5Ywtx2oXhos5xqb46QqqwmHQj9DsrVBwbYf5CBU9QMggP4J9AP2D9ho6IRyjoNmgw
 qJuU2kPWJ8F1zo2qXqBwBTVAKhJlXbUBSDIi+9blhtmn4eSZl00UhqDAkIkV/Z1bLIsOJDCH3XJ
 usIVCncmgI4YPsTcuENjSkR9cOqQtowfcuR+XYLVGRgQ+DBsQQWIO1s4hACg+VSTX6vqtMbjUQb
 jl59QaNj5dp6ItVNksxjfM0rxUsY8pQBSbQdWw7Qz8+AXU1fD2nAn5xOhdQ+zo2p6qxZ4d1V/xJ
 A2AMFC1NUbuw6jSAqVQ==
X-Proofpoint-GUID: hv4qh1HhQNvPlwwtdU5aA8LsAzN9Ejd3
X-Authority-Analysis: v=2.4 cv=TI3Q2Fla c=1 sm=1 tr=0 ts=6aed8ab4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=37pvPIjoEhJvAkar:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=DYhVNUyIqdWvmDq_ObQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzMiBTYWx0ZWRfX3FA0L5EkEVl5
 fydHHM8jNQ+yutTY1OudeMp8azKdozofLVk6yfULZljoazt3Gq3u5RMcoA9GupWkvR7flg9O6w2
 WEc+LSQSsbms/faKYJArgMYvNJ00Vog=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060032
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 11:31 PM, Thomas Huth wrote:
> Netmap v11.3 is from 2017, so this is way older than the oldest version
> of other features that we support in QEMU. The newest tagged version is
> v13.0 which is from 2019 - still old, but at least it's the newest one
> with a version number, so let's use that instead.
> 
> While we're at it, also make sure to check out only the revision that we
> need, so we don't waste bandwidth by downloading the whole repository here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/lcitool/refresh                  | 4 ++--
>   tests/docker/dockerfiles/debian.docker | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

I'll send it when trunk reopens, except if you consider it as a fix for 
current release.

Regards,
Pierrick

