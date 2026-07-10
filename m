Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED170C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJhS-0002Zt-Qn; Fri, 10 Jul 2026 18:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJhR-0002Zh-R7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:28:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJhK-0007yo-JE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:28:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3FpM1841602
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1VzCFLM9ou149V+IB+7ZEDe9pcUsbyqNqCY42j/y2/A=; b=mATTxvIzapvuVeX6
 Evi2y80TEff/tfhf4DwqAjfI1BUqmzPHPN6hoHd9W0LI0u/Gv8sJAvNDElCPoUKS
 64Zzr3xNWpGki89fVJKzFoRp2/Zi9DPcOkHy4wSoxWMGu3DE40hL/44KSIXufp1+
 nhovAv3tPUulmx71Sta14g7pVActiiQhpm0RCBaCyN0cPLvHsYFLokZWyKM6lC+5
 501pOTrZ/ye1tQLseUeYR6Wb9vKapcIOUfGsLEgVnnq3FVG12WonoHCN4/UUxFg0
 6B+rxVovVaNNX7XeoEJbdDyTGPxuMcN9lm3kmtuETkpB3+emcZHkvePH5GouqgE8
 Y4Bu1w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xn16c4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:27:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0d6a2f4cso15325131cf.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783722471; x=1784327271; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1VzCFLM9ou149V+IB+7ZEDe9pcUsbyqNqCY42j/y2/A=;
 b=T2AVVtr0K0LPikF4rUQAogMdIZSxn1Vc0pwjG8U5ouKVnjtcJid7lYq4YmongfAMaE
 4AgLimLCLfmp2yVUQqs5aa3se3JJirvbShEnAKwW5yGrNX6Mqep4cT8BR2NjW/9nASfr
 lD39UMTU3MV2vHod7aN4CO5u76JrKZa9FVtQXoqW3bfs2I5nwWV+ueznsGDa1Wg1uZUU
 2X+a/Og31gcjosc9uwOkIu3ZYWuNKpo6hnpzr4m4xQHEDJIaXfLwolBdrDSc9qlu/8pW
 wJ3qdMQgdhXD1zAKaNP1KNjDauEwkSfYig+aIAMBPoJhqB4uMfXld+de4UBQv9RQ9sF+
 QlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783722471; x=1784327271;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1VzCFLM9ou149V+IB+7ZEDe9pcUsbyqNqCY42j/y2/A=;
 b=McDGBsi8JwStlLkLTH6PWftm/aeQl454yTcEhVh7mBubdRqCCzEzMWKBrbrKZ75+IC
 7OIzuG6bjfCB+gsn39IQYBYD0XAYLwXBFQeuh0+HDauHgbo2BVDIiIhxl4PO98dI7Bj6
 GRYTAhUSfj9hKZG+fvxF7v5miL80TKWmiaxhmzmHXDiQ2LYuOttBW/6GUTrDPuLehO/V
 vO89zrwJoO1hdVcg3FCdtqcm3Z5vkM40J8Pg+VffkQZ32QQjO7AETHHO7arcyUqfLfi7
 RiY0yF4s13Y45zp10YRHgWkFQwNxb30VJw3aM1oGKif4Bl5pb4GPCn8YrHfSE5R+0XxA
 oQDg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqxx/Jh8lav4iSCEdMYoUyML33/NwwiA7uzA8QQAeH+uxDolWL/7yK3ptvxKip2CLVPG/4qmS/yQwEv@nongnu.org
X-Gm-Message-State: AOJu0YxbWlMXPZuSEo4ixtHH6q3iG9aSD7TJesTzZUIYBaB359TyLKP4
 KXXh9rQ47trket3VtAywF1iu2tpcWUw2hfpJjHemn4KMZQ8SFK68WBrG2L9RP2LSRxz978PE5V5
 4aaRvGKF0c/27vWnE0wFbcRRZ43ViwZ5n7lT+XZdPCxut12whBqIrkIRVWQ==
X-Gm-Gg: AfdE7clnvcxDGzUcrGTeYm50N3IvsfUKeoewGJMCWZc3MCjFdu7FZ4YT8CYFxoLnFwo
 UQs01UU1k2Xuc7dyej7oMF4AK3NRLx26Bgbf6niAY53rcYG1tbJUUfsLZgXAxO7SA4d6JiF/0PY
 DTmhGA4teKxPlrEE9GXgUZRSHLUzr54aKZ3j3G76n7GjVY1DhCebfdAd5JNqCOw1PDp9nM+Tho5
 4uLvunaZy+qtmqpdLkUI5uHR5024/henMYfpf6/Jm8rvMECg0tJjHGK94nSN36GXLhiQcWoerfO
 3qzKGULK1ILOqXsZtYFSQvO9RxDRdM7V2vmrWNS3mxBEAhCTkXJMEXjrotL5/3HGDkngz+RHJKF
 KPNKg5rAhKRrvMp3CVs7hnGAfZROK3rEyUleoxQBbIY4VCpWjwiCd4wRI0m8FNw==
X-Received: by 2002:a05:622a:115:b0:51c:7b12:6004 with SMTP id
 d75a77b69052e-51cbf3052e7mr8359711cf.80.1783722471682; 
 Fri, 10 Jul 2026 15:27:51 -0700 (PDT)
X-Received: by 2002:a05:622a:115:b0:51c:7b12:6004 with SMTP id
 d75a77b69052e-51cbf3052e7mr8359491cf.80.1783722471286; 
 Fri, 10 Jul 2026 15:27:51 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6d5055sm167875325e9.5.2026.07.10.15.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:27:49 -0700 (PDT)
Message-ID: <78730dab-8c03-49bb-94c3-f9090c3f5a30@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:27:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 41/98] tests/tcg/aarch64_be: user tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-42-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-42-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JJYLdcKb c=1 sm=1 tr=0 ts=6a5171e8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: WEvMgvQehIDl8sK4P2UjqYVjN12kRur0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNSBTYWx0ZWRfXyPeMKcCoo8Al
 D9/QecFgCj2me/m1Aoj2DMGQ0VWdrw9/i+r3xXfz1+PYtdaoRkjYQwVr4ISBIeBWpKtbWfmbIwU
 SV1+pJPjTqUf/GCIL1SRo5n2IvNawE4=
X-Proofpoint-GUID: WEvMgvQehIDl8sK4P2UjqYVjN12kRur0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNSBTYWx0ZWRfX7aIdy2eJ+84Q
 Wr7px/OnI0HhbaolSdXiBZ0+TLFULz+/FOQba21RW//faS5SImBiKNgKzRuoVpgVmWKDXZBt5Up
 pB4AMjXW3+yxTJTNlVw2c+GZZHkBgLmCt/DnkF+1/K7fVOOHmAROcyZuWXS18/0DIW++L+Spa2N
 IWPWZRzBSKJOC1qR6uMlIAu+u7kTZy1JCEdBghgHLRbvyqnrOCpX3bJDxfThKfVQtBCO5dIALW3
 utC/G1FOvLqLM8yh6ftYi1WwP6pgxr8d98QDynMbN7yHuJ6dr4CYn8I6F9i9tRrcNtdUCkaDY9U
 9ymNW/WEoLHAX3QaBK+Jggo5FoUjmjsweoDuLmOIeGXkLNeNQFZqJeWYT/fZ4/2DwOQVPpHbe8w
 WXf4eyvRIe9WUKLhh37pAEl3KqYgNm20q22ptOOQNF3PyBlLsb1XXTPjSp1VvWKL6DN/D5Rq0qr
 MTM8p5LTmfY/7fYzJkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100225
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 10/7/26 23:42, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/aarch64_be/Makefile.target | 17 -----------------
>   tests/tcg/aarch64_be/meson.build     | 22 ++++++++++++++++++++++
>   tests/tcg/meson.build                |  1 +
>   3 files changed, 23 insertions(+), 17 deletions(-)
>   delete mode 100644 tests/tcg/aarch64_be/Makefile.target
>   create mode 100644 tests/tcg/aarch64_be/meson.build

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

