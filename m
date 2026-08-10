Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190FEC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXrw-0007jZ-0E; Mon, 10 Aug 2026 17:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXru-0007jM-5N
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:49:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXrs-0000oU-ON
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:49:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXEeH1585726
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8EjnpCDky5XWqkTzM0RuzyzERPMg0PWEDWh+0BYe/y8=; b=Cw8QsTt/KIY1IXEU
 4Jpk9E3Bb3alVlWDE3aEIpFTCEMxWvo0i+zNBuKNYPNsafE2N7EmUHA5v2RYWve6
 QTB37KR1n0QYBspnxeOg79DBRu7gpuKFtuEeT/OvhuosaudRXHMzszocr/TyJuoU
 fGuym0m+DiZ/kR0+HNuL2jmUDWumrrqBOb44v26rXRKqDAfIavrZs95pEdnDYuCg
 YVENKygG8aNekadhbTQucvn2/ztB0QTjxMkX+m5+x5Zcfb0ibcDm+4GQQzXSnOky
 lblhAxJPsHsLb7n52zKBFYN9+PVbcRhMuX8TFVXTBOaQrnuoMjk9yjXJtHrx3Z8S
 9Rujpg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fycgety6k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:49:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso3743101cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786398551; x=1787003351; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8EjnpCDky5XWqkTzM0RuzyzERPMg0PWEDWh+0BYe/y8=;
 b=AYZ4e1WaYVlc3HcqwfI5Q2vmF4YorbtG6FQzCvsK1ruLfri/FM8RHBrrWqxYMVwrgn
 7OwoHTPqLU7hq68SNUMqoRMUjUMsxAG67uXM4dAxGXHcnlkwliTD5wxX1hF54RfeJLtL
 Q975FZrBABre0oeAH5M/igpPheXRanQjLYUIdvDmvwBERYKJtmrUOVUPVs1FuXTN4FGX
 DvSj8/ACyqkRqJqXPZL0z4yCF2qq0xONDfuZE77HAAhwOQqRoMuz+EBrp7aXLeCiWp5X
 HGIB0czoL47MRmldj2FUtP7748vfLnh8Ml059Q9qlScZvzbSX5sVl5sKAz5zdTorAhbT
 EbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786398551; x=1787003351;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8EjnpCDky5XWqkTzM0RuzyzERPMg0PWEDWh+0BYe/y8=;
 b=Kx6itzzJ+hPEaYzwlxSrh8fTtMN3GW1sMyVpM/WoY5pO47qf4tuz30Uq7zssti0zhi
 TGAFqam+2jUvtxTfFAjMKGEXW8RsyckN/S2msAb1Yk1RT7zfvqvTfL9L8c096z6I1nfY
 Ztk2CVXGTM6vFMIQQ7UsbAtNdZOjA0DIMolr3AP3xQmhBOzilu/CNB3ryE7xh0aKXUuS
 5FQGZeuNNxQzbXtuxAqyjuB85fOax05L9haw7vXaj+GZP7Flj/g5jtNxoeAQneNalrJD
 LdYs9xmb/NfH8TlZvthd4murmFzYWfqW8TVFKoJtihpKca93e8jT/Irat7Eim7D5O9lY
 ujOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRuMN8luzq6b8s60kCz9Yx1oKOBpULNJC8OAuMvc1q0ObphtwGeagA1nvFMnLNDssBYrmnicRaVIH5@nongnu.org
X-Gm-Message-State: AOJu0YyOaWZZogcKSZoTRytGynRantEAe8a6ZERC/lMbUmmfBXO6Jt2D
 nDKoOm6Pfpc7Tu36PxA9iLTHg9XKr3GeNx0y4C/155Tstv/DwYvh4HCVRKzT6hFcoG2MqPlixvr
 fyS4rFeTtAVd9z3dZXOgKc7S3yMCDQ4Byj2RykW9T1Ttjzlv+p3EmoA9NPg==
X-Gm-Gg: AR+sD12rIxl5M159zc1Il0nPjY7rVmueXLwI1IO91MfwBcp7hLvZoE7qNPHRxfbsfBa
 faILpwgdI8rsI5W808Z7RvOHMt2i34XOO8rTod51TA+VKr3cP/F9apkertXikLYDm2H83mCsrRk
 TqrNJ9YcQIQE56xfsAg9XVrlpgIng0dSImtp2r7WhZIhm50YGeKQ+2kNGj8eq4CttMF9ZpER0yd
 wifz+rx1FsGszLRwxweNYqbSzmquQRd2PuVVieXzXQHbirVAKzrhiHwBMTviz3Ar76cKzwAneGu
 tph1m4U0vjkncctPjk6zUuhol6cwRX+0pvWm1xPAKDYnuV4Cbn1LEPhR7tAacdh07vJM5ngAPco
 59LEeYNCxl+bNszoggUt+Cnznxu0xMm2QbdA0wixv
X-Received: by 2002:a05:622a:30d:b0:50e:474a:47e1 with SMTP id
 d75a77b69052e-52d514bf630mr17327731cf.10.1786398550717; 
 Mon, 10 Aug 2026 14:49:10 -0700 (PDT)
X-Received: by 2002:a05:622a:30d:b0:50e:474a:47e1 with SMTP id
 d75a77b69052e-52d514bf630mr17327321cf.10.1786398550375; 
 Mon, 10 Aug 2026 14:49:10 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480020be8f3sm35749069f8f.0.2026.08.10.14.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 14:49:09 -0700 (PDT)
Message-ID: <ab1837fa-3e1b-48a9-a2d7-70cef35f1ed4@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 23:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/39] Make HMP optional (and later standalone)
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JaWIyylLOhbxy1JB8qddAqlLcxAIylxq
X-Authority-Analysis: v=2.4 cv=R4cz39RX c=1 sm=1 tr=0 ts=6a7a4757 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Za_XWVeujLkPIwvmxgAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: JaWIyylLOhbxy1JB8qddAqlLcxAIylxq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4NCBTYWx0ZWRfX5aNhUiqI8jw6
 lV8uB8yjkTn240Lh0u5vflmPVHrh0bTKbhKMeTMOjHNHh0WtRaGPP+wiIa4CQ4zOMuhwTsClfQg
 LSrwKb0YKpQlrGZ5GI+4TSxPspbwLBQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4NCBTYWx0ZWRfX//cZCzpW2cB/
 XnrQSTKxXTqAnP4IUSP3NBRk3UvWnlAL8+qFU6TaPGoZIzDpiCjGV1eUUU5lVbXQRI4AC4bhJ/M
 y419mv/UdiL6cn0SfmZ40MAnTdYblFNvmLDHT68PqjKOl4dyCl6lFhuH8xOYgqjzuQjujTDVhoO
 8Fdjr12ZufN7UvLkOtAWvR9Jy4VlkJcaEvjLwEJ3/HPIZZIr/tmgmunhZ51dx+bfTwgFiM0etLy
 +vauhDEkVpt9+xn/Y29j04WcuCGRl+iKR33g7CYqRcGCyieWkXVG1+lN2Z6E8yqqklhe1JhioGo
 hArc8G7b8LkWEE27NQN2gihUWdZxbhHLzSoW0BuRhY9gfmKMiobChv8xdy6ujwhSJhhnuFFKu0A
 TN03qGZ0lTRTosTUNL6Ni7nbqgzoeBaiB3MpLrIBO1s25t63Q6RucQz2rWzyGEkBqz1QxmtWtEC
 P1J8nTFU4YK/adSoSSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100184
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Marc-André,

On 25/6/26 23:19, Marc-AndrÃ© Lureau wrote:
> Hi,
> 
> This series makes HMP compile-time optional via --disable-hmp. The
> resulting binary speaks only QMP - reducing the attack surface, binary
> size and enforcing a separation between machine-readable interface and
> interactive debugging console.
> 
> QMP offers almost all the functionality HMP could provide, so a separate
> standalone "HMP-like" console could be implemented on top of it.

I'm in favor of the overall goal, but am reluctant to the amount of
CONFIG_HMP #ifdef'ry added. During the last years we changed our style
to link unreachable stubs, allowing easier code maintenance. Are we OK
to deviate in this case?

Regards,

Phil.

