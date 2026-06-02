Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AD5CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUSFU-0004CS-6w; Tue, 02 Jun 2026 12:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUSFS-0004C7-KA
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:45:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUSFQ-000103-Vp
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:45:50 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652GTcBN2692168
 for <qemu-devel@nongnu.org>; Tue, 2 Jun 2026 16:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OtdLoAmowzeV1OqY/FQBn6DwrJ9S2PlosqjUBKfT1qY=; b=P+qoCuWp8JCa9l5u
 X+LonycRDUikr1VkosIrEIt927amXC8JNVAy/1vq9LK+DJv4ve7fnGtlpjAT4+w8
 r2Y+zrWpD8z2K+HMycwPBM+/6z6tGbZ5hXkYpTDViakfZCmjrz0GFP7+Jg8aPmxw
 oO5nj0oM6fvNUuCkIhnrHozycGUbXUOV/vP7iQI+MJELgPVOz79I/9hCYc8GBEzd
 VMaobgPn6oMiLqPSQbmqeeLMdxRSdZWAJD6Hr2lDle1QxUybLcV22qBIxaWkJ87T
 7EUjotW/sfBIjtgenySVNOhk6H6oMmrnp2hJMY0o/0M14RMHlGU3BvrdgfNoawA/
 MF6C1Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqumk2xu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 16:45:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304f23c55b2so4185490eec.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780418745; x=1781023545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OtdLoAmowzeV1OqY/FQBn6DwrJ9S2PlosqjUBKfT1qY=;
 b=gbQP8IHBTQB5wu0xxK64eh3BUgLvek0ChZCITmEBW6dn+YED8djE0rGDrLetjlx+4i
 WJANUewMR1+YLKhbJ3CmTfl4hNBCP3uo14Q+Dsn0BEzfJx1ah6Uem1CW/I6xwuhv09/A
 caR9Cw77atx2uEhjF71TGtezH8Aiwd0BMaksqeIfHCVe3CYm6GeALYn07jA52sQd7Weu
 BW8IEuAgpynY+/pBSUpi2JJ6FeTrqpwtvd+6oCXRQEB2lVjroYgSrSqvDuj47wjJv7fG
 tpMS5sOudmRomt4dOuu9qQP2UakdXSLv+SIrc0HwlQBEV0fQ5ssXHmhTY4HyudCx5LXk
 bRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780418745; x=1781023545;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OtdLoAmowzeV1OqY/FQBn6DwrJ9S2PlosqjUBKfT1qY=;
 b=XFXJY50Wqo9ykST+3oMPqUSi7uHbUNyVsMAPJBq7sbFa89IOu+3h7A56Q2MX4CSyxG
 kPqk45Jrv8TFCICrWziz9hGpddSsLItNyCXecOi5WdqZ0Ed2GCfoY0ImGSXiDAHhHxMw
 ST2LVvipW7QoSbtqgaejLpFv1SeSk8Vrjxqp6f/Fy6Yxj0Vff1nvchE+8FxGkArYAdCo
 qbXARDtbf8DhBGUPjJv4gq4WT6ZzhGtO4/tY/FVF3JXYG6e5db1MHatTpg7YeGN7pgis
 oaVY+zIP4Vr0taozdS4YgZvrr3m5ZNYRFkh5xUVOTtMaK73BiLtxgtUS9b2oYVT9H2EN
 /R1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+f5iJeFsv7hh20i6cprZxy9tmRvYVuA9xH/ipMFwZmYNIEbh+wzRdCsn2CmxcIZ1rqY598ILx2Fvub@nongnu.org
X-Gm-Message-State: AOJu0Yy8nWOC6FNJMFC2sYZExR0iq8QSNeWqcjG5sruofKqKrkx/0TZY
 Oi6pixlbqrHZz5HuJc02PjLvFFkwAabc3FIINe47OAjZxtE9cSLkwApDbvPa50mP2zUO/+vG5BL
 bFSEY9rp+E1Kw5eOo3cWCVRvCjd3iJXQgSI1FJ/ldW/vgd4x8EpAio6bqMQ==
X-Gm-Gg: Acq92OFUBGa72wNs/eoIiAQoprCZ6Ra9IY7h4FHvVnO7dtElL76L/IRnK8a8CYoEKPJ
 9NboYgb5cx6OwzLIJsAV35fiKFfWPwLrUTSujOi1SzWsvGVrz/3Q/tUaA72eH0YA2Cnfe395TJ7
 Kxwq+ozRp9fbdly2oWHWzjo/m5iZVHbUw1OLi6+SjaoVrAJYw3VBG1fZvibr5P5ZWXrLfynRprM
 eTYxrPNGuRe91Oso2w70bUqUAH6CHAWzjJN+O4wWehsOoFenObRqWlrCNsEog5BWyJq8G/81Xb/
 uuNW3n+7X/2L5YeRPv7iKjjpAkELVSlDhEWDeQDfz+PciKMVSbPcNAwJc3u9si/Pd9O09Bwj9nh
 Jj3lvDxOEjAvUChc9sYyrRlRDzBHyqydMGGtVsE5Dr0oQSJu6r9nc7/hgRyju3NP99OhSP+LqyZ
 lvZgC5z8mcP9G3u8GnCK8kyg3I
X-Received: by 2002:a05:7300:f18f:b0:2f5:285c:4374 with SMTP id
 5a478bee46e88-304fa75bd1dmr8013112eec.35.1780418745317; 
 Tue, 02 Jun 2026 09:45:45 -0700 (PDT)
X-Received: by 2002:a05:7300:f18f:b0:2f5:285c:4374 with SMTP id
 5a478bee46e88-304fa75bd1dmr8013096eec.35.1780418744766; 
 Tue, 02 Jun 2026 09:45:44 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5f6426sm11779799eec.31.2026.06.02.09.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 09:45:44 -0700 (PDT)
Message-ID: <afeed54f-b0e5-4099-a393-28cd44c42910@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 09:45:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gitlab: remove x64-freebsd-14-build Cirrus job
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Warner Losh <imp@bsdimp.com>
References: <20260602162457.828969-1-stefanha@redhat.com>
 <20260602162457.828969-2-stefanha@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260602162457.828969-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2MSBTYWx0ZWRfX60uyKL6bP67Z
 Q+BHRgPXW1upDPxmWb+U1iFA2Wz9+iwt92viZGpOobvpiSMmruGuJf8kovONxa56WGhiqj4TcMc
 RxrBcNQA3xWLtPuHblNugK4YtHrp8kWWHhFzYEk+uBUG27PvOdRtkTEBMKYC2SGQrU6qH2VPcPy
 QAQk3jc6T6XzCSTJ1+Lepgh9Y3tXuEq5Yv/x8rSyCwHQ4J/ZwrTNS/xjQx/0EOl/Y6i3DGyB+3c
 1rc9onwd/hXicuCKPuYDb5HbHF6j1ec77W5oc90wGnz9BbESVMh2rWJ0330N/xHPwPMLMFV34AW
 SJo2APhtH/KK6Z48Ih1fq+FGHswRsVfXRMuKJ9YWKfF2m7L7vsOAXNFC5jpKUdiP6JVhoGKBx7b
 A6YXgfUDTV/VmOVkf+LYzUrmT6j4lKW5Ub+JBitKGORQ5INKkSHhJPTeJbCcbZ0+YQfDJwW22bt
 MwvtZzsnSquHBolWBlw==
X-Proofpoint-ORIG-GUID: ocw-q8e7uf8yB2KVU-QoNd9cb1kUqmt-
X-Proofpoint-GUID: ocw-q8e7uf8yB2KVU-QoNd9cb1kUqmt-
X-Authority-Analysis: v=2.4 cv=Rrv16imK c=1 sm=1 tr=0 ts=6a1f08ba cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=-vmEVLzYlmb3bOZ55IwA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020161
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/2/2026 9:24 AM, Stefan Hajnoczi wrote:
> Cirrus has shut down and the x64-freebsd-14-build is failing:
> https://gitlab.com/qemu-project/qemu/-/jobs/14656732122
> 
> Remove the x64-freebsd-14-build job to get the CI pipeline passing
> again. The next commit will be to remove Cirrus integration from the
> GitLab YAML and lcitool since it is no longer used.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS                         |  2 --
>  .gitlab-ci.d/cirrus.yml             | 14 --------------
>  .gitlab-ci.d/cirrus/freebsd-14.vars | 16 ----------------
>  tests/lcitool/refresh               |  5 -----
>  4 files changed, 37 deletions(-)
>  delete mode 100644 .gitlab-ci.d/cirrus/freebsd-14.vars
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

