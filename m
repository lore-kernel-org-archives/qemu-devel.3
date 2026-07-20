Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4135AC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmg2-00034O-J6; Mon, 20 Jul 2026 08:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlmg0-00033o-Qo
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:00:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlmfy-0004pj-TL
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:00:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KBhxZS2449944
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZNRQ1iAGJElIF1I3eGXvu5SrrnAwjtiDlpO+ADiJ7Cw=; b=GwEx4nks/LXB/DEJ
 I5X+VN7CaBdptMkukD81BSG6gAS4tzWZ5aANP7eR0QGQzmx+xTBdjDUaj21UV4WG
 wSN8/ew27qTKICOHKlwhCRD8Q30CVj4EuO97lFz0CU611ifMbSO+39t1GaH/fBGM
 w5CVmm3JGFzuSgurgVZWoxPdzbqV6SynhkTaFcFxO+E/u1QrpDanI+Mcn2IMIr+c
 JWESNxclY1XM0EzujszNnc+T5ya0zPBNs00dl2ZRoxBiudV8hfsGAkabZe+zZO6q
 5gRP3ZYS20EVKTx9gO23wVDl7s7rXnQ8Sk6zhhX9ts2MVCVOITcuOUr5IqPo+taO
 iT26TQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhk2f81tu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:00:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bf321d786so85396121cf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 05:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784548848; x=1785153648; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZNRQ1iAGJElIF1I3eGXvu5SrrnAwjtiDlpO+ADiJ7Cw=;
 b=PcV6Z3SZ888Jt2dDS18lgo6w+DdSzXltMt+6o/Qh+JKGMGPWwP1uWHRgjshH8+Mqos
 zcUfRf7ia4zRqI/N26fZ8+ZgubRQUUVZzcztspEjJFoB/IteQluZnm1579eyyG02ruHK
 r+VlQu3a22/npnyk0dfKviw4UWm9pQbQkzYf/WxqOumaiS4Q/ixxH4udHlPKdlx7LxjS
 PyyQeKNpSZ/RfyuI2Mxz1CGzaHLhOPqUjSvJlIaNwvtGL9mWXBF0FCDVvoYoBonx8jJ/
 AtEdi0cOWr+yd6O8Oa6eBdCGPPnnS9YG3jkVE1NheoU7MRP5ixdgNykqo7tezTdjw+Vt
 4xvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784548848; x=1785153648;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZNRQ1iAGJElIF1I3eGXvu5SrrnAwjtiDlpO+ADiJ7Cw=;
 b=qfEKmJ+kP8Mr5nkQvagtDzVv+KN4gwDN4e8ZpGSmXMm30g53yF5Pm5HSS++XtlygPz
 N4HsSGDAW9VxRwGoyvjp5NCDP5AgQ7L4qpUXz+sJxtm3oNDGfDHiisw9f7aIcluIyLw4
 G4FwGnCRWtGgG/dUcMa+FcpFirchqDSy1T1eQrHOELJX8/oaOIwvUq3bcCjzJ6qFt1jE
 /hjomAZyP9DOfUjHmBP2RHZoL8RNh0fm5cam/2ZUDoOuVS8AwHKIHQv2U9aeYx4Q6SSw
 qWYoUR/9CaQ+ikjkMAHOJHY5HnfZ6eJOwdTCW6iukUZ4LGfEt2rAOkL2ltPpVhhdgabJ
 2p2g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/Q6LPaAeS71huyLF3jWVHXEPcCIV9+Q2BmjOXrXorVn09vQb4IVzZOIqC433NpLHD2VKiq7hcZPC4@nongnu.org
X-Gm-Message-State: AOJu0YwW6f1YQ5u8zelVsSnwWCP8CaEeVsnPUBZgENBtMAeSI7MWN1so
 +TGWso20kq6uwzaSA6fjKtuhzxcz94U+3R25U5yamMAVlAcMPjVM6YpFJ+SLJZZBxiOIbIMX2gv
 sQMY6NV5pkCQfiubN6W0Qx1XGaMdDCrh2M9vJljXpCqCLqFvt5uJVaXxjbBK6IyW5bQ==
X-Gm-Gg: AfdE7ckCFZUei70CCOSSQ5gPtu/4i/FgFgWGqY+PxhhT/yh/hYSQCZb5nMNJ1b+AQY2
 Qa4P4qPx+O1xwlBgI+2F0xuTZ7203PKx1rsI+IzDDTP3qjS9shhIzv27MPdmkE4xQ5B+6MppWb2
 zKAzIAL/zxKD/kmKwOtPAgXEexVTNQ6YakGFHJBxo1FFMRVrHBKJbXTFEJ7qPsVtL/8GZ5HH9Dv
 UlrfIlCjKj0uW6A01KuIndNAVEr6JqSHe4EQo63EXwHg0GPYu9+mhspc/PDWD0PUIcxd9pLU7PA
 vRlKQT1YL16eQbvkAGS5SFHsY5ZobGnJrnVAgmmstgXghZXx4pynbRjC/8fz7oDFu60eYfp5hXi
 GBVhioByNeHog4bW6HTCmNADfaX34qd+PtS2xIU3fh6GZevSPCjQ=
X-Received: by 2002:ac8:5842:0:b0:51c:7b12:1201 with SMTP id
 d75a77b69052e-5213f274ab8mr128102761cf.79.1784548848190; 
 Mon, 20 Jul 2026 05:00:48 -0700 (PDT)
X-Received: by 2002:ac8:5842:0:b0:51c:7b12:1201 with SMTP id
 d75a77b69052e-5213f274ab8mr128101531cf.79.1784548847026; 
 Mon, 20 Jul 2026 05:00:47 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a3e2a9sm273873805e9.4.2026.07.20.05.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:00:45 -0700 (PDT)
Message-ID: <00e2d001-62c9-411c-a241-d1a2bcb107d9@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/qxl: validate monitors_config heads[] in
 phys2virt
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260715072722.1643289-1-marcandre.lureau@redhat.com>
 <CAJ+F1C+pNG4HWNDL9a8D4EU4HDW24eg8S6eVHgLs+=nE3H3Y6w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAJ+F1C+pNG4HWNDL9a8D4EU4HDW24eg8S6eVHgLs+=nE3H3Y6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cNOjSDCIn1WwXIy2ajDfYZ-dTDy1qNyn
X-Authority-Analysis: v=2.4 cv=X8xi7mTe c=1 sm=1 tr=0 ts=6a5e0df1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEzMyBTYWx0ZWRfX2lLrZZT+a+nj
 gejEmIWsSl5g0/7GSTm5Xt0m92nn88G6jkqjrPJYe3TCbKRjtn3x5fDqMXUETQHxzzSuCRvnC1k
 qAenB+jAqcl6J+geMNXSEQiwVneW2xg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEzMyBTYWx0ZWRfX/t1YPSyqMmdl
 Rv0mYVdfAmU6eN9QI8aQhoMJf+rsgXGhHoTO7lPt6eRTNcubYxop4diXqhmlQW6PZmjO3y/QqRa
 Kdgx0rIqpxuZc+8+vZQ9O54HFq9Q0yavmjyP2SsPAoKjiVp/oHyqTky8aM4WS0DnoEhysGWhUGk
 Ucuy74IctiR+wsOZ/cuT8y9yHnzzOf1mvaFSVJz10x0iBpanP+qi45FNFpI+nSMMH1gZDJjwJSv
 u0QOKdumcq8Hq2w8wIdn8Vj214qUigagthgYV5q+h0+ctw8SH3LcVPB0VH8od+UlMyOUaynIKEd
 gXSEnzbmR0BXKrcOx3E742x4mywrKC5fhSLF6zlJLyfLV3/Gjaf3gsGGo44oZ0r39yhAmodR60a
 5fMObI1jw5SDaO+VIf6HJ0fzymJktvaALCBdJYq2d3HkfsjfS35KIi3n2IzzaFzmOaCEXnl6L68
 Ho81ZdvY0im5uHvIfuQ==
X-Proofpoint-GUID: cNOjSDCIn1WwXIy2ajDfYZ-dTDy1qNyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200133
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

On 20/7/26 13:06, Marc-AndrÃ© Lureau wrote:
> Hi
> 
> On Wed, Jul 15, 2026 at 11:28 AM <marcandre.lureau@redhat.com> wrote:
>>
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> The qxl_phys2virt() call for guest_monitors_config only validates
>> sizeof(QXLMonitorsConfig), which covers the fixed header (count and
>> max_allowed) since commit 8efec0ef8bbc ("hw/display/qxl: Pass requested
>> buffer size to qxl_phys2virt()"), but not the flexible array member
>> heads[]. When count == 1, heads[0] is accessed without its memory being
>> validated, allowing a guest to cause an out-of-bounds read.
>>
>> Include sizeof(QXLHead) in the size passed to qxl_phys2virt() so that
>> the first head entry is validated within the guest memory slot, preventing
>> guest-visible memory reading.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4027
>> Reported-by: Tristan @TristanInSec
>> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> 
> we are receiving multiple reports of this issue, can someone review?
> 
> (why the code only cares about count == 1 here? to limit the area to
> render. in case of multi-monitor, it's the client job to handle the
> monitor-config areas - tbh I suspect QEMU -display doesn't handle that
> well, but I didn't check)
> 
>> ---
>>   hw/display/qxl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


