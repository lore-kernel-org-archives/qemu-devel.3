Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E57EC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn9NC-0004xA-CV; Fri, 24 Jul 2026 02:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn9N8-0004vT-By
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:27:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn9N6-0002F0-Gu
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:27:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lhrZ1992557
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ej/jbIFHJ7jU6fgDYpSb7r0e3tjEeP0X/JhIl2sD1Gw=; b=lrgAAoI6Z7PF3PVa
 Anpo2c3LNdwDoRVkM9vLIKOlmE1ZjR5Qeu5CwJIYZXESAX9bqx6NIPFmXeMdNzYW
 BwsdmT8nkHoPhZoAOUp6qMIumCWaZ9cF/OYNe+u6V5n797elhPLgxoFZo5CU6Iu6
 cSr6vd4NQP2nXmeaZ7H1c98epvn0NGHUOi6Dd1oHdsuMCq6QIOIhQFfbA96Ym3vX
 P/h2izg0x7jbNtkCuveoG9uZ/wk3AKHjQDspQhGCLSAyshE9Dr2SWE7/3l5X6N79
 MqHv7vmm7MoDuFju1s8XTaFjGubZRLOcS/JnkMQGwsjaBSzMRWMLvLSnYQNkXmZv
 xGOqFg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0p50dsa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:26:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c083f1818so1469401cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 23:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784874418; x=1785479218; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ej/jbIFHJ7jU6fgDYpSb7r0e3tjEeP0X/JhIl2sD1Gw=;
 b=W26zxl4WocZrWK5vRSSSv3ZLaALPSq672eQWFDDxPyxGcIyHE2r/F9B99pEA9tYkTZ
 2piSOe7QdWK2jnKJdris+mJ6ifGsHpDOnCLAwaxw2DvLK1D9IrCmoW2QZ4W4ny2M/TFQ
 lKYWmPBI8HeElk0p5KMk3atW2ZtaoqH9c5O1tDWvTR8SImm5qqV+aBw9yxtSCVw6m+zD
 nUbb0u+6t8dLdbkL2qnzh+lBPph+v1PEQIr4ntCQE2t+F1Kqo/3n4DbTFvogSLQyEhCm
 dSddaM33PVRaj3pT2BKo7JvOO5tZF1LRARtdELggu6R5W8MvH+NOpCLrTZMgyIW4qd6l
 +rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784874418; x=1785479218;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ej/jbIFHJ7jU6fgDYpSb7r0e3tjEeP0X/JhIl2sD1Gw=;
 b=ThpIgUWFCvoFGgnxkhaItJzEgMg/n0gJSPXbCdjVxaK2TDPi2sEqY8ly0AApSdJKa/
 URmze3v65QKGt3nqqrMFBtg1uJnLmVA9WtvThnck/QK/BMhRdRzJYO3SpomU3T2neri5
 m4RphJ/kOfWESKZRbfuk3uZyHMD5xcyWpcAQxDY8AFJN4ThWS/0Am0xgCabdYpE6SC/a
 5dsuJMrvoJMJFt4konRHHX2/ce0y1Rc+IOLZjeJ7EkmoE7XiH1K82FyOwmHOvoH4VtVL
 rS1xehsfhU8D6PP9JMoMOHLC8qkxGw6ujpnBpjxr2a+qtu6+6Qy3HBgdXZS0iIr7r4zj
 FiYQ==
X-Gm-Message-State: AOJu0Yynz/+8fZgmXGVQiUL/iNMgX8MkjdZXfZJ+gtMixclil7Vluv81
 dCI1SmrV7DaGTq6hpb+EVIEsZg7UB6+0rXV/D1pdDtlJP1EAuleb8JXFOYzQHWfIGnP+d3PVzWU
 OGXgEGnD4UubYldDkrV88IZJ+tBjKbACE8KbKUxZ7UTM+g6GWrJOhCA616g==
X-Gm-Gg: AR+sD12waztbhYpT0PvsY+/sKfvQYj8h50YKxIVegFCORdqVak6Fl86penyBxNUsj5n
 WXKKatxUgbnIH+ev81eIKCAd1PzGShK2PV+8PqaMHeSf4sSY7hgriC/G1HrkpP00edt0qffipo+
 fbWn9cSTiEnp5eiV9Xes/qTxGg82TreNGgf1K1pzcFWRrdL4saZ/1WEYnPoU0v2AgTLvbRKgQDd
 0ErTcFY9PeNwnfAYD45XrpV0PvdaZjkdKS0+TpfDGnV2LN+DMziOUGHKMdd52U/EX1A3TkpcHjr
 nLobVwC5nFWOF0SLxWwdjFZTxxQD/l/hMRaLKlyIrAyOJuYdOG3OnpJZjZdv5RqMlT9rmEzgcGZ
 mRYvLrtUqWupyfUXwepy+IEdSl1w=
X-Received: by 2002:ac8:7e94:0:b0:51a:89db:95a4 with SMTP id
 d75a77b69052e-5283ddb0ee9mr55210391cf.6.1784874417717; 
 Thu, 23 Jul 2026 23:26:57 -0700 (PDT)
X-Received: by 2002:ac8:7e94:0:b0:51a:89db:95a4 with SMTP id
 d75a77b69052e-5283ddb0ee9mr55210201cf.6.1784874417271; 
 Thu, 23 Jul 2026 23:26:57 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb57cfsm20867213f8f.11.2026.07.23.23.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 23:26:56 -0700 (PDT)
Message-ID: <63228d8c-2a67-4f8e-96be-b71a37e21bcb@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 08:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/vmware_vga: Don't allow guest to trigger
 long running loop in host
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org
References: <20260723124432.353969-1-thuth@redhat.com>
 <28b3741f-3cab-4e7c-b830-01fad0d80d35@oss.qualcomm.com>
 <amIwSvAAv-LWbmYT@redhat.com>
 <7f8e11c2-f7ea-4362-9840-a295a7def315@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <7f8e11c2-f7ea-4362-9840-a295a7def315@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Pq6jqQM3 c=1 sm=1 tr=0 ts=6a6305b2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=J_-Nd1mkAAAA:8 a=YSNzndg7L_ASFngmpYAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: ymqKdnSBo-661O4QK7j0h8uMqValCz3E
X-Proofpoint-ORIG-GUID: ymqKdnSBo-661O4QK7j0h8uMqValCz3E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1NyBTYWx0ZWRfX0TdlFQr70N3Y
 gIzZ8S7a7WHPcQRpuf+3x2Z7l0PZbDwvyoLbh40I+YeFGDBEtDaM/tGiy+76AD2dhFe9yfc6dKP
 RnFSk5gEHXt6k53Jmu8hgvCRJ+4wMXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1NyBTYWx0ZWRfXwVwIhGR6ie9b
 D2sF/701A9Gsu5sC7xIfYVfT34Q7ZkRvqQLG2yjJD3qPkmdImaRMSOLnHrUX7iFGxaj89omGzKl
 lbVfo3ICmypqcNoLX4PS0Atzl6BgZExcllz+WsunIw8bl5fVm0QGhCgdNsfg/7xOJE0JLvA9alb
 f/hWKd8mzhjcnSUWQCbwWCLzl25P9hioqo+s84zV9RNXxCcP1U+sPwUwbEBuj6UFHN9ScTlipc2
 fUcdlztYFOc09Wunq4j1pqJak526QtGTfcxvkPhm1eG11AEEOTbFshZASilhgGkkyoHUf+nFx2n
 SWsMM/URXFCDplpogSPM2jb+GnVZ/27IevB/wnTKRawyhXdq1a5S+qV8P4lixx1MdOzitxwGwIq
 awxD5Qz5zJ3fCP9HtBT3CR7TRTGs00zID5R0VWB418pGiHHzqNd0atE3SRmGFvpRhv5A78WtgRQ
 h5nfxVmDS3NP52EjoEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240057
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

On 23/7/26 18:18, Thomas Huth wrote:
> On 23/07/2026 17.16, Daniel P. Berrangé wrote:
>> On Thu, Jul 23, 2026 at 03:54:41PM +0200, Philippe Mathieu-Daudé wrote:
>>> On 23/7/26 14:44, Thomas Huth wrote:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> The code in the SVGA_CMD_DEFINE_ALPHA_CURSOR handler in 
>>>> vmsvga_fifo_run()
>>>> basically does:
>>>>
>>>>               x = vmsvga_fifo_read(s);
>>>>               y = vmsvga_fifo_read(s);
>>>>               args = x * y;
>>>>               goto badcmd;
>>>>               ...
>>>> badcmd:
>>>>               len -= args;
>>>>               if (len < 0) {
>>>>                   goto rewind;
>>>>               }
>>>>               while (args--) {
>>>>                   vmsvga_fifo_read(s);
>>>>               }
>>>>
>>>> Thus by supplying huge values for x and y that overflow the result of
>>>> the multiplication, the guest can trigger a long-running loop here
>>>> that burns the host's CPU cycles.
>>>>
>>>> Add some sanity checks so that this cannot happen anymore.
>>>>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3782
>>>> Reported-by: Feifan Qian <bea1e@proton.me>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4026
>>>> Reported-by: Tristan Madani <tristan@talencesecurity.com>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4076
>>>> Reported-by: Sunday Jiang
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    v2: Use SVGA_MAX_WIDTH and SVGA_MAX_HEIGHT instead of an 
>>>> arbitrary value
>>>>
>>>>    hw/display/vmware_vga.c | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
>>>> index f6f9edfd1d9..567806f0e47 100644
>>>> --- a/hw/display/vmware_vga.c
>>>> +++ b/hw/display/vmware_vga.c
>>>> @@ -737,6 +737,10 @@ static void vmsvga_fifo_run(struct 
>>>> vmsvga_state_s *s)
>>>>                vmsvga_fifo_read(s);
>>>>                x = vmsvga_fifo_read(s);
>>>>                y = vmsvga_fifo_read(s);
>>>> +            if (x < 0 || x >= SVGA_MAX_WIDTH ||
>>>> +                y < 0 || y >= SVGA_MAX_HEIGHT) {
>>>
>>> vmsvga_fifo_read() returns unsigned... otherwise:
>>
>> But x & y  are declared 'int', so at least on 32-bit builds
>> a large uint32_t value would wrap and become negative.
>> Although we dropped support for 32-bit platforms, IMHO it would
>> be better to use uint32_t for 'x' and 'y' too rather than
>> assuming the 'int' value won't be negative.
> x and y are used as signed int all over the place here ...

Ah I missed that, sorry for the troubles.

> so reworking 
> that goes way beyond fixing this problem. Could we please get this patch 
> merged first for 11.1, and if someone then still feels like reworking 
> the code, this could be done for 11.2 ?
> 
>   Thomas
> 
> 


