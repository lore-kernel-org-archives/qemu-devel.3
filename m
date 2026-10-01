Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3227BCA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 18:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCL5V-00028V-Ii; Thu, 01 Oct 2026 14:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCL5T-000285-5e
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 14:00:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCL5N-0002ww-SG
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 14:00:54 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsuBL2687191
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 18:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hsz4fXnt9uQybMPAFuja/wXwJphaoMDrfem6f3PD6f4=; b=dZe09uJ2S5r7C7wi
 sU9+VLTOZWsKA6c+Osd3yagdLc7RanPTKS6WWyfoYWsHeqrwzBtTvq6JEDd7mg6O
 Y3sUu5t5H1WZKJSJWggtjAoPl+QwuLY6+Zg81tKla/og8X9hTKGjoJUJQjlP06se
 cq4COaXNkqqgpAcuSZP2wBMuB7bveBOfPFGConPQCUXhPG0ZVH59T2E8hS34R3IU
 HU5lfkd45Rc5IzL1Pebstk1xpFae4EcVCmiSTTKziIyjMA2RDA94frSzwrgPzRRf
 npdT/QcM3l6vlQRYaHvfoSzDnQF49cWqJSCl9ifldaKv1kldxJ2tYBcEKYbIwULf
 QoPQ3g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a8q25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 18:00:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cab33cb20so341960985a.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877647; x=1791482447; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hsz4fXnt9uQybMPAFuja/wXwJphaoMDrfem6f3PD6f4=;
 b=JMlOzINz4IQ7EAPqJjbfVl2BVKxw9hFzRPe+XjSBjI0EM2S6jiAgKseVF1mQ4xi5sI
 4C3tca7PDuOD59cJJP5ZP3p732H7wG7xa23tZpoNOYB3AtE/gUF5Lk4JYMDAZgLGVuat
 E3puVhTz+q5F/2jxlNdMS1xbpQD5IHR4yPCbmz8oiHTL4sej4hl2Z+rjO40utqjxOVmj
 wSc08QqqKy1YZtTGerr+i1+FIrioxnN6sHKL86Gt0g/4A0iU1GOmVfC26pD+XJ3iUd8E
 ePn2BbY1tMFJfnyqGKIcZ90RhVN/gl8CSHUbwAhR1A0iLRzWQiFwdsDqE0o7d4jAhcMv
 yWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877647; x=1791482447;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hsz4fXnt9uQybMPAFuja/wXwJphaoMDrfem6f3PD6f4=;
 b=VGI2OzcmCCv6R/9OTIfirrprK1vzWBf0FxKAMY8gWZ7T57xnDy8QLtF+zbWfjGxdJ+
 9cfxEREOZvCg7l5PKvk9KDcECYqjr41OR+bqTvWE95MU1ky7zg+Oc9ddFJ6eR70mF6PB
 hB61lbBAFRxb6FqmHJCkKgO0HQRvnVhg8QBoys/yFMd9vmSl4QqwFcpNI0rTBahlDK7W
 6Odo5Cdmw09YLTzMoP2BAi6bafNFSDMYj0TQNv4H9xAtRM3xNxHFGJ+g2GuxR9NgH7FB
 UJlvsLHC2LzR5dQcNR8a2AdT++wWrugLIsj26PDyPnmeDHu4NxArL/XToRwLMWsFp+rh
 r9Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5oG5ENUHyvvoH+kscdvKdukHOi2WGAZiSYZV4bk7XkfoxdG7AeuKEjN4GC1rOLesJ9L9cUAbrsbaz@nongnu.org
X-Gm-Message-State: AFuF++k50iNqAmy/uC4FADCM4T/3gFf3lehJT+I93avJjHQYAruYw23Q
 biTz2KLJNc6uCqn36rufmioFPICg9jr49OWBPKEmTOs5LLUw4HWeOgwNPljKSh7kaFmS7MuAwBz
 SxgA7GbGbiZNswgTgdz0O/szAbM3L5gxHBqs0DwqrQPHQcvyDu7fBRTrhFQ==
X-Gm-Gg: AYBFou2m4gZHFv3FSjzuAFpsFwkXOz6DHB193f8cQepu+9b6H8boWk1qMTjWh/gyn4j
 zmD21c2tGsVZAmiERIGHFoSK5dueJYxmjecqCpr01ogbiXuJiHWXoN4IX8cfBhDK1/QMlb3hZri
 21PTSeJspTQVN3eIRh1pvoqUf9QXn8KCvjsLPTBDoIYU4MgSWR5imtfPOg4AUjvTAMrpDOURXfM
 J66Y3kvUNtfi5bJwMx+vR9vjuGeP2NvHbVa9FbS3Eei45+9iPTjjQq0sRylLczG2YJbShHV9l9n
 XOQgtSFnYm9Ol02yCzj3FbxDFrzhZcLE2CmBie0Xvb+np3dEVMr4LtZ5lr2N3BXnoGcJCe7Gbvg
 2AbBgPtQnTLCehwCPIh1rdg==
X-Received: by 2002:a05:620a:6910:b0:93c:6d02:9d0f with SMTP id
 af79cd13be357-93ca9724817mr991228385a.31.1790877647343; 
 Thu, 01 Oct 2026 11:00:47 -0700 (PDT)
X-Received: by 2002:a05:620a:6910:b0:93c:6d02:9d0f with SMTP id
 af79cd13be357-93ca9724817mr991221085a.31.1790877646735; 
 Thu, 01 Oct 2026 11:00:46 -0700 (PDT)
Received: from [10.111.137.66] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0690e060sm7150647f8f.19.2026.10.01.11.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 11:00:46 -0700 (PDT)
Message-ID: <b00f2b88-e68b-498b-adaf-4560c6fae2a5@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 20:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] audio: remove mistaken use of
 trace_event_get_state()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
 <20261001151228.3373747-15-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001151228.3373747-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX4W8Ve2L6AJoa
 BKu+IF2DPredNL/ap18YzzfDrsCUmkt2VxqPGM/XaPYsm3Hu5bxRXkjE5Avz7gz7TGhxPvRI0cL
 naC4BQVLdKv9zZBK8zx32b7RnctSfV8=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abe9fd0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=_6kI2y1DatARejP-zHAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: FHj-_f3Slr90IW2pwQ95oIpftAEYUBjN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXw0sfQYGZdUtJ
 +6Nb3KZMzzp1GSqXQ0G9rhxVPul2ewFBXe5JYu9BtThPLXvSX7tMssfHOdGdc2yQeedc2qLTxZK
 WlRq1iGmcpAKhxM67u4/a+SjVPU84oE4r2Sh7p++dnnZF4TyKceHdHaEWhxcVRMqiPyjX/cKf3L
 ljQEUOOOvYLFwv7HQoZ2/1IC/coUrk6pWIN+VAPPiYI8YU1qNlKzvTzlVrgc6YnqF4GaGvTm2pN
 9qh6dQgkIDphULFKPlI9N1E6wF5+BtV73KtQLgGrbwvXdWCyHqMdvx2MVtsM/AZ8HOMDmkUjTHQ
 HfNrcd6/4YZT82vOOxMHR3VbjY1OoUGgeycJMkI65rR3sNC2rPQdYewIE21cH9d9MDpLzj0j35Y
 nUTSeEyg1cFyavGs9YqxIPlo820Fj+5h5n9lgJEn9Jsqm3gXz/bBLN+eh4l5VkwZWgTucyDTw+Y
 CI24DNpsbG+e70o5jrA==
X-Proofpoint-GUID: FHj-_f3Slr90IW2pwQ95oIpftAEYUBjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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

On 2026-10-01 17:12, Daniel P. BerrangÃ© wrote:
> Conditional checks must call trace_event_get_state_dynamic()
> which checks the state of all backends, while trace_event_get_state()
> only validates state for backends using QEMU's internal state
> tracking.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   audio/audio-mixeng-be.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

