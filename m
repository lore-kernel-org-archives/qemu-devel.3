Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C61C5DF8C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxBAY-0002uG-81; Thu, 20 Aug 2026 18:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxBAW-0002s9-BD
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:23:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxBAV-0002VA-11
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:23:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7oox268445
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e460GvWzSXUhTDft5mbQbZR/FHWVg/lDMMLAVt8Hsh8=; b=a4zQN1uDDtoBDhGm
 oF0k+rtX3DMr/Bf9UzOA8gWdRdV5lCCvTf4wY7ax5sMX/VgAO41D6FlR8xgAhF0Z
 MKeJOYL5CVlzCa/h6S5dfQBJC2viyjLGOBZXNOiPYb1sD79Haq5oBUdQlfkG3yxb
 UVOb1NNizyKXtZktg805KQpZkRxSPMXth8e0KUiqf6n/si9A9tQGmgGLx5YDT+f2
 L09zAWipIqwp9uubEZTSa4Ods/BUkTdDwuqMDxDYB64QLWKuIvVykcgsXHg/V5b9
 nLL8FJ6nEf7ZnH8xSWp8AEpPLMqaOwEmEbOjJT4/eOz/2gVbUJhl150TZpCepDLY
 uTvxBg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg1b76m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:23:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so403221a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787264605; x=1787869405; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e460GvWzSXUhTDft5mbQbZR/FHWVg/lDMMLAVt8Hsh8=;
 b=IL/lGEtEgk0oh6BmsLQ6zk653/fM9jcpj1eL0ltXmUlXqO+dA6aKzFPBxH8y+oA9vv
 +aHbL48PIbHi36QNIUupW9+yD8nxeb5orGOShyV1tB/j2xxKBYYHQ3B1oAmqsjUpu1wn
 cam6CgzOWm7IcaFv56ujfIt3AtlVAHkMR4Qw/YaZE/ocjBHIENgwhQalq0oiwmB7jPCw
 qIHbqVzPQeWqO0tv2TH5X4wHIOtLsCT4CdRNDhiMAjhjWLC0D7+5ztT9g5HTR7RVwkIF
 DHFxIkShFsXiO9U/Aa/l21yXFKYQF8YoWYOUThVQhwthzc2rr80EeegmY8W4lRmEcMXB
 AEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787264605; x=1787869405;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e460GvWzSXUhTDft5mbQbZR/FHWVg/lDMMLAVt8Hsh8=;
 b=ML1laZs2R2PSMB9JrY4RdR4LHWpJGwjvZU2GOrotSCqtMSeMDmXc1nbHy27ExfcpHZ
 TG11UZrC+orWSFuW/t0qhRLRkE2W/iEaSOXqXHEgXN6na5OHJjHjYjW99V47jSIFrkN2
 vG99rfWU0rQvtqQVywGeOCdvoCxWI648p0WimuIoiEME6NWo1mqQJRM9JiPOyyM/cf/L
 K9FyCwyA/UR12WyPusOyTlVAMY2Qp7LTMSbGTyLATPeDc9gGkDw6fGygVG5dYEh67CHc
 hJGboanAZjw7v7x8cM/miLP/btKyI5bPsQDk+fRErNXztnPp0nEh1lUMV4uaRVrbpIn8
 yuAA==
X-Gm-Message-State: AOJu0YwECauYZ0uaIyojFSedvLlqzFaGMkeYylHaL5uwRwJlxhb8YQW3
 Lxh+1OxX5eMyX5XnRV17LFpwgn38oPzdCiLYXcIt7jv7iuMaeWTvnNnH/2vcZAVqa1GiGrvEih6
 gvjoiT00peXKD9q3armPfZdk1xbpGsn4ACKj+ghpj5s3iva6DX0obbGNVBg==
X-Gm-Gg: AR+sD10OeEEjHEn7a2alLs2DVitOSminec6fykcTbhuU9vnKkhROU9FQY0vT8bPMz8w
 98isfkDqDrJaK8g0PYgVebcAWq3la8MAw3Ldu0ZZnOQn3KTg3uMv34D9FiW07JgQdbsCs3dW536
 OqqVB89ZezB0kb//YlWw+yOG6TF5g3pO2PaUzor8gKcvcaKsBZ/4hwzNXzcIwgr9ouJlF9/+pGE
 6lrApNUZ/SQk7Fn6CRfL0ZhYCEp6v3Q403BBFMV10+roGYWzbuENJnsD+R/4IW8R50UXWri5rZx
 dWSShg5YU0f1xrXzrPllz43gOylT4IGeTZWZxhM+MW/Kfwaiw34nv0c1kp6H/eC8jMhJG1S+jC6
 N2k3TlJYWeoxu8Q1OX6ZXHpHLKQsMq8Hyuv8ekOm4mpZKppft+khqrfAQ2ss3QxX+wN2x
X-Received: by 2002:a05:6a20:394a:b0:3c3:9df0:2d66 with SMTP id
 adf61e73a8af0-3cd2fe31c5amr2747362637.6.1787264605050; 
 Thu, 20 Aug 2026 15:23:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:394a:b0:3c3:9df0:2d66 with SMTP id
 adf61e73a8af0-3cd2fe31c5amr2747305637.6.1787264604651; 
 Thu, 20 Aug 2026 15:23:24 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef77fc0sm36588912eec.8.2026.08.20.15.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 15:23:24 -0700 (PDT)
Message-ID: <82cb8274-7195-4402-86dc-0dd0ad9050ff@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 15:23:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 25/28] hw/arm/smmuv3: Reject IOMMU notifiers for non-NS
 devices
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162624.2809349-4-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260813162624.2809349-4-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: g-IMFnslh6rtdRadLWmnFA9d87b1fM6s
X-Authority-Analysis: v=2.4 cv=G7Is1dk5 c=1 sm=1 tr=0 ts=6a877e5d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=fgrLqfBXAAAA:8 a=EUspDBNiAAAA:8 a=vGvm3RNWxNDA6kgmdf4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-GUID: g-IMFnslh6rtdRadLWmnFA9d87b1fM6s
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX/I4nvT7PxdrC
 6qk5i3gTwj86YBxGjEWDUFEH+9M0bi9vnF/ZUIZ0LSb98fVFq6xNFY3HRg2GJjYHKvShBZZ970n
 Cf4E2Tly0Mie4lzntf+AFXOxIwuaoJE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfXwMjdG8IavwvW
 w6I3jb22ZjX/J4L66+L6fJ3eAtfB3xHtqm4yxuCUL4iKc5HqtNBCHI1s0rVLW8OcWJ1Rd7qSnGy
 Lvt4px8yro3NhYMCgfLO/uLQrBmY+ZgHseQrjM7NVjPEHLRvFMOpjnvyWk4afn0yxqvJTYt71Sz
 JImLMv4velYEiz5gwuWGFFhoSsLn73jkbbaq6POZgJxq0BPGKEBapn6emo4zd4CK6SYdP3k3w93
 DbqZOX35G8Bu+D3PuAViOovMIjfE+8Huy7jbKB1Hwz4ZKM1XfCZeEfC4U6CpjX+yBUUmN6t+WPx
 9SKLRQazJBJGJqU3MhX8REj/5BwC51FaUp4wD7PWaTGJ8UMxLZy4uu+0OA9yZ0KXp+dq2u7jfy/
 HbL0pVxhiJ8MuhI2uXx2+YlitJ5mq1XPCGH2nIYL8P0Y0EYCBAqxOEJ5Vu4/ToNnenbtDdnVyzG
 ximjzINUOmvSpJoKXRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200166
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/13/2026 9:26 AM, Tao Tang wrote:
> VFIO and vhost IOMMU notifiers currently support only the Non-secure
> system-memory path. Reject notifier registration for non-NS devices
> instead of allowing an unsupported configuration.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

