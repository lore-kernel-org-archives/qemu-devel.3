Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604EECD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXEOM-0003WG-Ml; Wed, 10 Jun 2026 04:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXEOK-0003W0-UR
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:34:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXEOJ-00056X-HR
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:34:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A7ilri867931
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 08:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rGhgJ0YNVVGJdJIhrXioE9s+m3PZGCBQYfOkZ5atW8Y=; b=UVx2gDV6gjYAsqLx
 6zq6WVCs/ry6IktP2HBSyrfhbKUQH5+gXHNNuqwiIIRKuN++T/KRq/hQ4NxsPMLB
 okz6yDPskV1zBG4HllfbVHOBrgKWqjXgmyOUZY0eGJpiM3DulzWKyVsFXd+mkPuf
 U+gq1Q6BAkLRFIOE/OReRYORN8N/gw5z5aEQbIYS98YT6h0dS8K05cM1PaOAaTqm
 6U6FlDF7Ae4jqZHREwfPwBwxABXlolbJ9mKMSpIRExFMOoEX+z1D13NXTBPHvwk3
 /X0+Tn7NcAggFGJIsZdkerCUD9iP3U7FTN9e95DtvBPxl2pR2JYhxw6j5svzYguy
 JLj2MA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0kd8x1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 08:34:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5177b8df670so109136001cf.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781080465; x=1781685265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rGhgJ0YNVVGJdJIhrXioE9s+m3PZGCBQYfOkZ5atW8Y=;
 b=OzYhmyvia0GbBxCZ4xyA9KPl+Q/SqUxne7EecyG7mhOjNzZb+tlOn4Hnn3qgPtyevX
 sRWyYNqR8oC0TBO+svfh1db1SxgZlm4I7hUF6vb9Psa0PxghB6K/keTbwU4D7oXSIjZt
 kvRsLkPjLiQfWFf1/45douZ01jo3wK4rCX4Ocgn0AYFyoh9QVT/VvbY9fczJNl4h0FQK
 0ghsBQi+ulE+6C7IKp+Sn+y70z7a80hCMg9g/Z03M5+Gj7Jzw2q8tXPMlRGlMlOAQkEl
 qQnLo61C5sZnjw58OvbK4DnyCOM+ef244ebm9ZFnG/q32DPus5LosYMTtQuNpIwJEIj/
 xGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781080465; x=1781685265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rGhgJ0YNVVGJdJIhrXioE9s+m3PZGCBQYfOkZ5atW8Y=;
 b=jUUBIf0V8aormXUnUX1wp2SXtuyebZfSblpJ7dREwdZ/07gbuLPznJ2O1HeJCGCxDq
 pFqXm5NMeLCk2nZ4pPLYjBRMk5j8bt7emUtpGyYU7qvSFuA5VNWBACKmCogYS/a23WX0
 7CVF52ih9jfZh/7/r7e9VWyeJOhZVvDsuHcAcwk2T5uS6iCPFLeNmMqfef/4ph8F2LqS
 Z0OEgMrcIDcUwDXjuh6JvM+BzZoi49Xxr7LJlLjyo90MU3RnVP8QBjNeBMUd92d16/dn
 QfKbGGGXfhWksZRL3y8svWdVpB8Bt8EfnJ5wtj9AGpKHM6syOPGyd6PxL9Lx6UbjM9Ip
 v0gA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eFe0gaNjb5bY+rYXQqeG7t6swhwxHlI8Zj/36tm+uhF2+Q+z5KhP8M+Qo5xEhqO/EoDlolcBDw6sn@nongnu.org
X-Gm-Message-State: AOJu0YzXwiDq2+pidslBnYQtl7fte0xI7lOzYp0OCDrg5QJ3vNiCqMTn
 W5h0mIkx1WKVbER2hnzdbmfgP+7gPzO3ILFvLAMiZFwCGD4EhkauW8kCu4OL+YqMasrHOz8hzhR
 9IOf1CLaYSpvFAvEUvu9z3Y9cJoN+eR1mNV6MwpJ0Ddufe50Bfc4bf6rrPQ==
X-Gm-Gg: Acq92OE/32MtOuVn5Nib/6/r+RHLJ+Ggi/mzL0gnhRxWS/yvkcPbxlV5WMVIkFAIAi/
 mD95PHZQ4rs2aP77ktm//blFm/ZcyDXCetZj1wtOS+9XPXRae5QTE+ibbOClubiyH3CcBaMtwTf
 7rXtBfLE/aWUXZX+NknKz0mpnLdlZXplTeeDq9DQvsI3T/YfS0XnjPImuX5UxbH+ljhYBzPdvXH
 N6A9MUCNhZWvHKpcPsvyOBHgZ/+BEIphGcFWeWt/2v5jYn79h7TlsGI3PO09FU/eWKWOte5dEBj
 MCB8AXUtTUIgN00FzG2dTuqN4A9Q9A656We3taZ3Eyk7vv6v9iy9nF/rrTueXQmOkSRZND9w6dT
 PfTpSU1gVJkYBmWUJFLb+w6sx0NJ4H4PhNrvY8eSWS/nHTIDkDwasRrQaHnfrc5KT7VMWQzXbTg
 ==
X-Received: by 2002:a05:622a:1811:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-517959d5454mr340518221cf.11.1781080465359; 
 Wed, 10 Jun 2026 01:34:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1811:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-517959d5454mr340517741cf.11.1781080464842; 
 Wed, 10 Jun 2026 01:34:24 -0700 (PDT)
Received: from [10.156.84.244] (49.170.88.92.rev.sfr.net. [92.88.170.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf051770994sm1167552166b.13.2026.06.10.01.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 01:34:24 -0700 (PDT)
Message-ID: <463f2096-560f-4551-bc12-41732c1e6288@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 10:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/27] tests/tcg/meson.build: add default flag for testing
 compiler support
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-15-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-15-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a292192 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=YLXAUxGLE6hMr2F5uSHVqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VxAk22fqlfwA:10 a=zgiPjhLxNE0A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: OaDiMbFwdzXj1fSjpoRrE5HiWWujVHV6
X-Proofpoint-ORIG-GUID: OaDiMbFwdzXj1fSjpoRrE5HiWWujVHV6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4MCBTYWx0ZWRfX2AhhR1FaxbQ+
 OEvgyjhqZgHZoBuenDWNRSltPS9HEx1cAdOzAYAmD2iio7yH44b86wgSfhS8z2EiVzGZML9Lwf3
 VQSmR6jYJD1a841FBf883FhQKDTYQbDz0E9I5QVSdpXNr90LJvbeOmVSOdp+Ah6DPJXBJTWANRy
 yknwH8MnmrFFxI5cGkTW8wt8iSrvIRQ11vntAwGM3aPeFqEpP0EIaybyBAoXyL7Y9T4mBumtd9n
 3dWTg5kfXgwcA+uac9YWR4cZq/049N9zKeZERtx47p6c0+DRPEcffvh/TvEWxIrrH2nSsM18ke0
 18EaJilT6epatbbV5Ginl0Jn9qx0NkkXevE3lGVvCPPJsISRrFg5Yu/GPzVSA5hAWIhiJKeolbm
 //5jxe/Wi5nRbKcK/AHiGlv7vVGpEoCkSCV0l4O3oWtLbqg79VakaAeO6ZgtFM4QyrDfdKc/k7e
 aY7/pSBRy5I7pZUaLrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100080
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

On 9/6/26 23:47, Pierrick Bouvier wrote:
> This global variable can be used as cflags when checking if a compiler
> supports specific flags.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

