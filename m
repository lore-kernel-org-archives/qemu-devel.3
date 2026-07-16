Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B24BC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQfv-0008Gm-8e; Thu, 16 Jul 2026 14:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkQfq-0008GG-8J
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:19:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkQfo-0003og-HQ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:19:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGScXG3002042
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pc0s7vJ2rgJbDkUfkpS01tMX4nZilVw0nKzIr8UpMxk=; b=Wjs8wXm7Su3kwzhR
 ouB4V4YLgUtNwzj8ICF90uG38ZEpEjrrarT7C0jsUiLj6Tk4i9xLD2NbrNs4iI8Z
 Ri6sz/CzNOvS1E9IzTLnWRmlcWMaskf++haOhZmHco7GV5Lve91gyku54no76OKW
 ybV1zPdSAhPVTE6BZCupJAR5eoOtulaB9ALiDB/799rg3XNyfSdBZF+Cfk/EL8kL
 xpgQgAWichgjZH6qEx2DQ1MMeAq6CI7pG+tJWPoQ/0Y8Aq8fCIqjbSFKEmlkAdYn
 73fjaW6nV6NtpODuV9Afip3BrBceelRlMeJ7LWT66Iew5F5soBrZhmUqA3k0URPu
 2pvkTA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff1m9gurt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:19:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so10274651a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225941; x=1784830741; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pc0s7vJ2rgJbDkUfkpS01tMX4nZilVw0nKzIr8UpMxk=;
 b=e+NyRKj5lxTcKwei3lNF9YD1bmVDzKArkSRjmVMtLyOIRYDEEcyiHO/vs20WSGtOo5
 /f+NZtTLqWa0eqt6t54IumWIIt/93S2zO7SuHgU30YuHl4YDGkep42fhwsMoqN284uB/
 8HRfGzU8igicgzn/SzcVMUToT1cB1nxepaOi2Y0MW9sDlfNG0URI/FZ45PB+69+k5kCK
 w3l9Al6t50ri+BlinKJM0lRyhpfSRqbkWxePYjWuaapJOtWdlF0+iRhZgi2vnzWG5LMR
 YJbQotJhz1yQzSPIRIyAm3FhMhQJhZ/8uye8FMPTxQBbwwuWbpe6E4+shaOxAyDYeNNo
 ZhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225941; x=1784830741;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pc0s7vJ2rgJbDkUfkpS01tMX4nZilVw0nKzIr8UpMxk=;
 b=V9ygAUsTycJOpp3McaP3kwNzVffQYqG7LjXVDv+cUcve8SpCpPMg7DLFvxlYEk98Nd
 P+YKpSSnWy8zbPCwjT0byMfC77bdKUID4NKFZSFDC8+PnEUhYUIiFJZC64scO6w/xwZy
 SPTWbdecNFWf66t2GssFsQjYcMF4rW7ZcHMqTC5RuYMf6tCrNyCvLjSjrrHPI7Jrg6US
 M1vSe2doavl59Oa4gtYkfYHODYZcoTVSYs5xb+TTm23XyB2PTeg1IxSlYe88XwPxrejF
 Rr1Ic9nNOgqcdLqswi7F5WGKVLgakTev33U85EJLjlOs+rS2ieuVPMrfKnGk9lSMiMuz
 6hXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RriNfbjl26vZ3ag7jFwF1sqhoEYHRDWKATyBHHHnozyALa8jZIyWWcHJSTccqDb9MnB2iYp4NJzDkQn@nongnu.org
X-Gm-Message-State: AOJu0Yy9JJv0Ec41AZG3HKOwGobz9k5M+l8+ElsjBxTGuvHaOm9Sl1CR
 902HsZH4mvL42S3CUayHFfBq/L/RRWwJW+JnFtgpnVZG58HUO/DcECsqrOtVE1Txf08XoEN/+bZ
 tt3BN2BHdZnJhq9tHACGmOckwdsW+UuqOGsCYBoyaorMoYCH7rffZMza9og==
X-Gm-Gg: AfdE7ckNmE3bTE87+bEjrhk8+/aPzlULC+7Zl8BwGcPTOppIyYohy0xikfKJdnbqjUv
 ni4HskROHR2K6Dd+P2PPHA2goFVgZJsljm8BBwzd2pTk/+BSY2bj33ZB9jeE+5qAxT/Elcs+hWV
 SORZRU0ye87it0vEnrP10Oe/dlD9YiHMGaeRtRKyIOo7TeIxrtnYEJrBBcYW1LJldKlk9IhIhfW
 LMQH6OJKyFfM4+G1vTdy7xsOiZpcLUYxUqXrpogVyxZ9O6BGeovojCAymWjWBLhuN2b9hRpnVSk
 2vX3wBOC62FVAQLfUQdTyLxTTL/WcalKcZheR9WlmrJ6ygn9S4Zd6Tnn8oUGFAeQLUyK358zBGp
 iadFg6fbRjoQH4Af79MISrk7o8iEQDvK26rcmPo2tLJHYDmL9mZRS2WFkHnmikI63TzgT
X-Received: by 2002:a05:6a20:394e:b0:3bf:6c05:ab with SMTP id
 adf61e73a8af0-3c34d8935e6mr14192994637.58.1784225940931; 
 Thu, 16 Jul 2026 11:19:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:394e:b0:3bf:6c05:ab with SMTP id
 adf61e73a8af0-3c34d8935e6mr14192969637.58.1784225940487; 
 Thu, 16 Jul 2026 11:19:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c08eesm17291577eec.21.2026.07.16.11.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 11:18:59 -0700 (PDT)
Message-ID: <319dd074-646d-40ed-b61a-5898dab001cf@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 11:18:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] target/hexagon: fix improper assign of cause
 code to exception index
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
 <aaac9492e5a4b8fda69b49a966a70d975620ec6b.1784225209.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aaac9492e5a4b8fda69b49a966a70d975620ec6b.1784225209.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IMIyzAvG c=1 sm=1 tr=0 ts=6a592095 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=giujFzNUr6BhEBkM4iIA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4OCBTYWx0ZWRfX/jF+MmX3BAPe
 5YJJ9CC3PllasNRnCeVnkCpGQGS9YglSZ+5J9/KZjQY+cP7o1JlxCnDM7Nk3hYHZJuF9ImdmoR7
 DFvsPLOIuLq1NjzO24TGy3Nf9eNFgUNNimDFGXlbzE2hb9C2RgNT3uwKvLQwgr9h36sgU4zb0a1
 A7EHPwmLuQAkKIKZsbig6hqWsv/Dcthhh4lx3W7iyByv3/pXHah/dtPOBIlFu/TZBPjtnBN5ymM
 3HEXgxP9mztTMDNMZCTM+Mnh8oKM10v9fSQiy2gsJcYjv+W8SeuzRe+nrnic04bsPJXzAqDEHIw
 O0au/qeI+/L6DxXeXMdbTDSW9iXstdUAGSLhxcyQ3aGu2RiEwkhpCEidLh7UWZisB8WsOki6sqm
 hwdGSwj0UAOlHMKFFHc23qleVZKsuzYrheM99QoKcliX9XSHTMBRp1bwG5SWftGNMDHwQeO0ZFS
 SPtY7gM/6yjCbQOQJSw==
X-Proofpoint-GUID: o-PX975xmiT9nLP_ctQtj4kePdBctkOf
X-Proofpoint-ORIG-GUID: o-PX975xmiT9nLP_ctQtj4kePdBctkOf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4OCBTYWx0ZWRfX3NKjs1GstYZ/
 DwmM1t/s7qyPBoFbkANJu58RuUnXWpKXy0S1d+JSrqgzkMU8rw+w1v/6X+3A0PdWMeRp9PQD5ig
 pgtGhgJQIMY6+sqUdfe/B16ZHUexkbE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160188
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

On 7/16/2026 11:06 AM, Matheus Tavares Bernardino wrote:
> hexagon_get_tb_cpu_state() detects a misaligned PC and raises an
> exception, but it passed HEX_CAUSE_PC_NOT_ALIGNED (a cause code) as the
> event argument to hexagon_raise_exception_err(), whose second parameter
> is the event index (it ends up in cs->exception_index). This causes an
> infinite reboot loop when we reache a misaligned PC.
> 
> Similarly, gen_exception_decode_fail() is called with a cause code
> (HEX_CAUSE_INVALID_PACKET) but unconditionally routes it through
> gen_exception(), which treats its argument as an event index and stores
> it directly in cs->exception_index.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.c       | 3 ++-
>  target/hexagon/translate.c | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

