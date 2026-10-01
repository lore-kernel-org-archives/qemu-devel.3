Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E1ECA5FDD
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCOzi-0001oV-Nw; Thu, 01 Oct 2026 18:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOze-0001n9-Ry
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:11:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOzc-00039J-Ua
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:11:10 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FseCE2886387
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ia2xqc0OjQNsmK5pIGrhiZdU+vDUSUSvtMZIubG85JU=; b=o3Ud5phZzRyU1ACj
 CoeX/yTah8oYKbcezShUwsB+8620TWtmTApah5AyTKjTFnQ8Cs4q6TPBVTuiH4wu
 JBpF5uiMCHUov7dbb+rYCTigs2Cs2uL4XfmaHOQHIBN0iTnD9hpwh2IJxt7xUwEG
 uaM5BW8dFPf45i9+YIpwhBH7wnqzL4EQ9XuiOLZs4OLl/HaBA32vFHKYFg1LvtlJ
 6dOBn3al2aVPGaDGKJ7slvXImbavbivunmUhQiBFmUZ3eZLuUrQC83UgMn+hrB7i
 h1LSNdoS1iMCk5wGEUr0GVGsxhcsaVxQjNglPR/ebrbyZ/NFjcYCN/PRFDP2Ar1U
 8Ag8xg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1sdcj0na-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:11:07 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1466ab2bc8dso9800639c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892667; x=1791497467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ia2xqc0OjQNsmK5pIGrhiZdU+vDUSUSvtMZIubG85JU=;
 b=kY1jDyAoQF55Qtq5LdqrOYT+z/ZqsDQs69xxnJTpyYXSQoHH7l7vYRWr7iCWM2ts2n
 DtAid7OHx/bRQuk+3OVw5U/yOLoPkGvfpMsJHyPJyFDTaLgvam7EiVl3nCAcj4Gf9pfH
 wpNyAOk6ql2YkW+J1+E+1Z9KOR6D5WoN2c3zshfZQ1lv/1LrKrc60jB9e9xfDUpA9VfB
 v/c9AoE0szSDWghIxkgH1uRKp+xj3fbIYFHhmIAPfMbtweNcecEKGY9r9gL+NraATfcG
 rBc0KVrejQlmmgKa4U5v/v0vu4AQzl47RdwPyAidCt1ufhtQoy1omV3UQR68S0LgYYDo
 ucbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892667; x=1791497467;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ia2xqc0OjQNsmK5pIGrhiZdU+vDUSUSvtMZIubG85JU=;
 b=uHIzbQvr8gmvmtsQo4lYjkDcKNVDKm6z+aAKx+xH51QLzDyLba7sE1QJMOYqnQUr5/
 HOTbyNGY0Rfi7ApZOC1uWZ4HcpciTr3xfFrkrMlAUMKJLuGeYJqnTfLoK8lb2Z28Cgr+
 jCpqUyERCA9sczxu5Ry2b6JcQq2XI7oiyWCKJ6EvNGaxbhgm8UCVin6lA86quvOACi73
 G4gi/yXViJ1JEJ0kqy3rBnz+bNIKJ2AFdp05ZOJnkDbapJ13veCMjYlO1urmpAZ7hywD
 HC/KWhC2saRhvVOdvMhWPFmqdwzbnFhhTnH7KT/h1uMOQWOL+S42O7oUlg0QCfmqFSo7
 goMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBywIOgVq6aBsO7Udl2NE9QH+cHB5YnclF5TzZns6BdyTM0h/RxIN/JfXvvRErnaVir7e7pxdXqv6/RC@nongnu.org
X-Gm-Message-State: AFuF++mMEF5Lk7NyOT35IqkqaPo+q8v20bU/+VDE+QXuCzTWNIjStG4H
 UL37Kiwl+rQqhtTJu4MwZZOD7wZF9nI6pNhaGl0AQmwTOnvPOVVT3HRX+2o8dNYd8LCq07U5GE0
 Jyq/dZDUGYF6g7wyuNSDnku2jse7+8XR3f3/h8U3gka5I225Ma0/B2RosQw==
X-Gm-Gg: AYBFou2o6Hf8wexGRTpXdJGIzdLAMrVetISUATwHlGyBWaQmvrm0We1r5y7U3vikPUI
 mM5M+8YYMzmO45o88U7b4/QGJher1s5LM5M0TFFhM/tZgZSA3QEJitUC5oiCDER1+D6jfAj5Mab
 ZFH7wqaEO2tbjV9ffIe1XIsnwYzf45gTgFZjfF0AjTMVoy21XLh1+F2DTfTu3ZBfHgvCQmEvxlp
 3J7JFmMfYwGhMckVufBXxI6gRwSwzUTin1H+VZd5Urd97HZ7Fd5EyQ2Lk0Q8PX0cjrJYdjr3zOC
 zYPpMJFfHY6PZ6QYUOYEelTktMZiJu31LbmxC6wclqrOMisCGUSP2r6vKNE6PTUlXp9lmFIcz3j
 TPWPjNYWWrlKBWmYYglBTuvpb7gJspd0wdWpQtRDE7PuZiEgEso3y/6Ze/aWDSb3cgvdE9A==
X-Received: by 2002:a05:701b:4588:10b0:14e:d0ba:7590 with SMTP id
 a92af1059eb24-14f5b3112a7mr637362c88.15.1790892666539; 
 Thu, 01 Oct 2026 15:11:06 -0700 (PDT)
X-Received: by 2002:a05:701b:4588:10b0:14e:d0ba:7590 with SMTP id
 a92af1059eb24-14f5b3112a7mr637336c88.15.1790892665921; 
 Thu, 01 Oct 2026 15:11:05 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f984e4sm1045491eec.17.2026.10.01.15.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:11:05 -0700 (PDT)
Message-ID: <a9ae02c4-5c7f-410c-b1a6-29c8ff82d5fd@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:11:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] target/riscv: Stub KVM functions for
 machines.c/cpu.c
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-9-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-9-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JzLvztjJxyaJXKMt0BYnJRUGEx4SZ501
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX+sNqGH0PX3Kl
 12CWZTUjEJxmpj62N5ySPh+GfYox9h4zVXTM/r0RfB7f3XVEayfWs0kH5gT6nMTq/xhsYhr9kK1
 yibaM19Hm4xGxzeyH9G7aTG2i4vBPhg=
X-Proofpoint-GUID: JzLvztjJxyaJXKMt0BYnJRUGEx4SZ501
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX8jMaRyUjy1Bn
 wIqIWI6uadpR5E7o+tg05g5zF1XrfC4WExUUxkivCM73F06YECnAc8gutsPFrL7C+D2VDeIHCyZ
 fNL7XvyHCS6oMTnxZy4NCnI3CAhhwg3Dl2WzJlZRcrU5mRzWgxubRl5/1mNXHNvMvVvI5uXRlUs
 Sb2CekmxvkV38YVBrKE38DimyI5wuDtg3rZMUijqFa6rpdJnNQcsLxSrFk8+7fsq8gxezQlTFn3
 delJ1rmvKqQ9fUG6GUyk62D1eYTqXbhIEtzteHBatP6bD0D5ReVmAIImyWTS8USXF10Fj1s73Am
 joTwKLti3gMwE1cTxhx1QG0W6pz0u3RuoiKqjZU/ILtE9WlI5vjFv8Y8rqpldvjqvxW+u9Y0bwd
 Yyv/rYRk3VASqpSpY9h6t5pf17P8FtdHGTVL6qtNRQ/G6dcUaiWdYW12Ec18XzASV181HJx8VJp
 xs685jdEOEEiw8/baAA==
X-Authority-Analysis: v=2.4 cv=D87SufRj c=1 sm=1 tr=0 ts=6abeda7b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=hgEYH4ClCF-yA8-lyV8A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010088
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

On 10/1/2026 8:59 AM, Anton Johansson via qemu development wrote:
> In order to compile cpu.c and machine.c once for system mode and keep
> the linker happy in a single binary setting, we need to stub out some
> required functions otherwise only available under CONFIG_KVM.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/kvm/kvm-stub.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

