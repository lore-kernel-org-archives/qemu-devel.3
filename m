Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBB6FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 16:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJwbr-0006mR-QO; Mon, 04 May 2026 12:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJwbp-0006m5-QY
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:57:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJwbo-0006Fc-34
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:57:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644B42RY1151327
 for <qemu-devel@nongnu.org>; Mon, 4 May 2026 16:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H7+jpDELI9bjlBmKHGv3F95JJQYUPQ5Ay9LJDj/BrdA=; b=lARNlRLPfSgPIEzz
 q0TAbdbtdAkhAHdHE0h6o/RTF9Ka7Vh1rdtg4dmAAQKY6M3v+KNz2mr86rgpq8Mj
 iBLaWYDjlafA/imOnx9vvasuVAmgIV0yiDgeKnpH6wvXgodGZTYAOXbU4FEKzIRJ
 QmzN8CvxFDWIWvjHILsGOGvxclVj67m3qW2xScjnV/aHm7/P4DxmD5U/1bLb1Lf6
 I3RJSjyxwATiGqZGkU7Z5ZhOyvLac/1wcxc9l4WjPJkgw5L0EHzOQKcmnX5GyObi
 HU+YACcZwjTLq0MC6lo8+S+jE2vG0xlN/KtYWqbTl4dy+4R5yBScw+W0mDTfCxHH
 s59Tng==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxscy9bt8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 16:57:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2da19227bc1so5117080eec.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777913845; x=1778518645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H7+jpDELI9bjlBmKHGv3F95JJQYUPQ5Ay9LJDj/BrdA=;
 b=gxuU1DS62EhB4f0mxq8LBb58m142W5nc2CPCmTl3TgVotrhs6VBLGq+sB2038ImAxO
 Y+gaFAUlv9QDesQzKskUKSEkz/rl2iosRPGPsCqkyJO6KZ54LhxvEtRJ5juRCPjhFvA5
 urLWFlgMnqe6xXNeCBqnd5DFgiBtzxXBAjpT1VOg966HUSWyU64iyBAuU3ka2MVKbMJs
 nNxP+/XMDWcsF/fvK35ToquiGLlHaDWPG3SLhwhQBIld/HlfoHUYX6zZI60nTzPl8/jM
 2TtIbEj/erHo4chrKqdUVDJ5HFucdHi5hSUXDlhNAh/jkH5GmP+G6FHN90rWwQXXPit/
 WSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777913845; x=1778518645;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H7+jpDELI9bjlBmKHGv3F95JJQYUPQ5Ay9LJDj/BrdA=;
 b=Gh60NpJvdwtlyCgNPVw21odWFbg1uAuVnpiKsUh4xNFlZyz2b0afUxbiJFYeLNv+yu
 rjKOlTx+dCuDWLIKAEngea7v5FyXElQw0a4NR0njgt4N8F0rAX9fAOG9YKK2zbnnfrRf
 kIhH9p9JHMntPo8RVQSX9AtgjjM/18ce15QmjtaLE6mPHO5ByvC4x3FmehUOuDNsH13M
 aVjZuKvLfanw3g5D0hrFEHXnMH8O1esnNZr9qNvxo4ThNGQz1IMB1KwBQKjOcZ8/ioSl
 Mz8X7PkIz9XxjEgjRGj5cg2z+DgXlzPcA27oqy2U4m+T2CVWX349IpJrXwU+4QIAIJpX
 zINQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pBmpLRTPGB9plS6hSbUw9lnTbYFAgZOopxJGhLh+3BHRxODKvxRtMf65glgqxWDLsa2mzwUFWhEti@nongnu.org
X-Gm-Message-State: AOJu0Yy8Zdz2YavIi52kHKgC29mIb9vewfvTAdvPY8U4V1Jej/Ozwu88
 Ndf9OzRW2y0d8osGrWPmvkVEH6Rg1ylG5aohyr9FW2BPXcfOg3mk3DkrSdRtLmnkK7dVMyuPW2X
 m17GqQ1Wm44L3TnJyNZ/FxOsisMNPQ5gdNdq+6VP6CABOVVvpVKD7GW4fjQ==
X-Gm-Gg: AeBDievQ9JuowX/yfu4/fCTDh9foXiOlX1ju+KHD9t/nI7lrBm9ZGpWAfB1/Y8n9JDv
 YiQ1pNvx8VevM9aAQMv0xs8UU6KnsqiT2MD1zlL40/F+OytQhqm5NEIzg5gMdjzwsIO9HKygi06
 8e3KgkwBLeILS+rRhSv+j6kL225twKRBEQS2jyT8S7q0kOv05xBBCLFdVtPbfSxONz5Z5Tsyj3h
 ahMrwkkE8oboPRj8vSw2shJFA/qM0A77cbYNJ9EXaZWlMJElMWOK3iG3mOfMc4c62ptUcIi0iT6
 KjlzFm5fGcFsNdeTcdZC0xP4J8IBN8N/BrCWq8tM0JboiDyuPLlrR4bs6TSOrRm0jI1BIHDoH1t
 4hpAJHGpPDHeBK/re5lEEvI04uTAPfOxRSBntze8DaacCWH0Vw7iEC9NW/Qu9jSSWAUAu1Km5Xh
 8Bko0lli8Ebx39h9/vQMGhLfqJ
X-Received: by 2002:a05:7300:d509:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-2f16252fe2dmr2967258eec.3.1777913845034; 
 Mon, 04 May 2026 09:57:25 -0700 (PDT)
X-Received: by 2002:a05:7300:d509:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-2f16252fe2dmr2967216eec.3.1777913844343; 
 Mon, 04 May 2026 09:57:24 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3b783a95sm16963467eec.22.2026.05.04.09.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 09:57:23 -0700 (PDT)
Message-ID: <a1f481e2-a1ab-45a0-9c61-2e89801352cb@oss.qualcomm.com>
Date: Mon, 4 May 2026 09:57:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] docs/devel/tcg-ops: Stop listing dup2_vec()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260504125032.35465-1-philmd@linaro.org>
 <20260504125032.35465-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260504125032.35465-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MSBTYWx0ZWRfXyQx3XpMdUJJJ
 cV91EH6VVnuibFYqVhLqp4Ilh1qetsUu/tS7hjEwjxf6o5oyCYlpyDVGNBQIRCtXsnsnOv5jD0/
 CKOqu67d0fohbPPekR5SSz1yyzjuKnrU07iVM5QOTs/jjDZJe7XPl4yVQyA04SxKm9NZPdXH5aV
 Z8z3Rx9oHoJmu+HfFIOAWfhK56kvzHQfq4570AVjb1VHdETzTI73PzyKcMGmORKVFkPj/1JOF13
 dvrO0DixGtPa39qidhWQirXbLiFlWC0cHAJ6zAqxRuXPL5EZ0Tg6pnTTJz09wnfq0Y9URwXBRNt
 tFQarnHzVSqstS7Ftjo20dYn6p6LjR/ff1RyM99SVr9HiNyjPmOSLM2lHtW2bWWM8dOWvR1TeU1
 g+SPa/mCtHgJB1Fy/URlJ6Gp48knhFdlBWsziATlB1CAI5PRS5iKtpqogkyKr8UR89Y3dk0fYkx
 y5d+svWU93+Ymd4QeSw==
X-Proofpoint-ORIG-GUID: eWG4KzDs4FxEeHyyRn5Y69MdXFh2fWUd
X-Proofpoint-GUID: eWG4KzDs4FxEeHyyRn5Y69MdXFh2fWUd
X-Authority-Analysis: v=2.4 cv=C47ZDwP+ c=1 sm=1 tr=0 ts=69f8cff5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=lDF0YcFSIPAaTHKB7q0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040151
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

On 5/4/2026 5:50 AM, Philippe Mathieu-Daudé wrote:
> dup2_vec() opcode was removed in commit 6e7b13936d4
> ("tcg: Remove INDEX_op_dup2_vec").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/devel/tcg-ops.rst | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

