Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3E606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nHZxatPN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P7nW0tB4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIOx-0008Ca-8i; Wed, 25 Nov 2026 14:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWIOp-000881-W1
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:11:25 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWIOm-0001yO-Kg
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:11:23 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APJAsq4648251
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 19:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fT+K3i+y098OWKbf6Z+Mf/qsgf3KIVojTNjaPxClD8E=; b=nHZxatPNVWRvmOti
 eKfoqrf4oPRGd41y9JpHiw4tQtURC9h4SLFrAtnX1T/5uY93uVrF1M1zeZMjhf9x
 Aht0XEz3405iS9UFeaCBOsm30Z2MTBaRRz4XKr9POxOJx+Yfw/0J/UPhLudDERLR
 HAMFlYXhZNuv44KvRXnzlRMY3HB9MEnWvIBs61rtePDAT46SXq/M589nuPp/ZIjs
 NeXWGvvac+qnrVYsnrwlRh1V3eZXwe7eSH8K4KVhSipCG7P/6gZWTrQfQT/PpdMI
 uAwWQkufiUgExHuZEudFerzJPVEXuHa8/btm6lJyLd+lX7hg2kxmT68AMdSkVZ/X
 jIjNyQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahs668-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 19:11:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so1094766885a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795633873; x=1796238673; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fT+K3i+y098OWKbf6Z+Mf/qsgf3KIVojTNjaPxClD8E=;
 b=P7nW0tB4EmyCHQY3nFLHei/pxDRy+YTKoFaldU6B8rX5g2xgA4gRAYT8pl5vTh1yBm
 JLbu5HCuywJ7XIofREnaxfHf0TT9FRXvhlc5PoMPqlQpNqfNLwok4BX3tWKc+77OkpVs
 H1EKwp+FwD0jyfJdyZeYa4RiM2QpwE1JLHwQfwrzt2AgBcT0SdsrN98jQhsaJWqj41n4
 MU9/8JlGYv94XG/2SMW35yNwKH3dTnu2QSguZbuj0jOSt3jo2XzorFPwsEinEC5V9ud9
 u12XnZ9nP2/8QS7bv/x1hdDyOXa2lWoFZ86hlQPAIjD8Td7XYTh2sJr1yF/QDVZtMZmH
 ZDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795633873; x=1796238673;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fT+K3i+y098OWKbf6Z+Mf/qsgf3KIVojTNjaPxClD8E=;
 b=JpRvQx9/hM80TFwxbzV17r2ji/8FwUAd6IYU9E+I5A0fndjGJLDWRc+KfFasp5xpWz
 Nt+lGkLE6zluLC5y8kT3fjZwReJcYzx7fbBD/9XLRpUeOIdFbEE3JhmuvF6w+S1aTmeV
 G9jXGdp8mx2ZhV3P2i5316QIy0oRPlk9zH8pBFvKG55KbiRzwX+n4/FtLtIpQ7wwGG4c
 uaTSYvzh0jJW2ZKWBPOWdOOuPnWkDVg1CBGndVgSbTyp97AB2NBkamkfeXF7FNQa0+GT
 M52QVZQjg699eGDJfWT/6oIcmcQLxhiqhH8Xe5uuqeVE45781cjYBVNVtngtOS5ge2AE
 Dodg==
X-Gm-Message-State: APuU4Z9vRbwSyA62WHEvPfJOKszVNDQ2cOL50Mn4HfYqPQ0Nvi+rprYB
 xNzKUpJhrwu/NU5G4NOCuyjcTkX6qrcUTAxIU66fK3YsZ0XhoqfflLfG3zZcbFkV4hVLtzjX0GW
 9UtiNa7lAD2ZUka5FwTdRMrPb/mtFwbTOsob+kBLrggp+8PuzO9S1y/9icg==
X-Gm-Gg: AZFdTZcyt/fZz2Oxf7uEgk5Fx9vvwMj3ftC7Iw8/mJebd8u3vjSlZd3HJu+GjpQ3XbW
 4oNhyOIQ93j2lj3huiNUgq5bJ2LVc5UGdtK7JoFPdOrA7HVAfP3I28n9XJPcAjRsrHba6VSHsBn
 oXoV8TrZh9f1yXCk0cpjbOuD6XQQ4CE2pUZfCRHqVJV1sTUc8fPbu/v1mLEdQG86363+L4Z/JV7
 XV1U3f41WkqxQojpcuW8htobjcaY23l1Rw3pzeEmCRfFSGN+QH7IYLm9DDaKFaH1wxO4oYyzk12
 3e7RvIdmR0aFUnfayklvIrhaKV31NB8pFO/NEgpwiyRKdutYK6USzOuoifIcrG57dpgzupesw4M
 VgHLHSVRwgQmOsHOYdZEJ/+TUXF2sMfrGEXfP4i350kkqk0Qo8m/0Def8EtaWsdfb5dL8CwRMie
 ALFEtZdTQ=
X-Received: by 2002:a05:620a:7118:b0:93e:c12c:43ff with SMTP id
 af79cd13be357-949bac8120fmr3189905385a.76.1795633873298; 
 Wed, 25 Nov 2026 11:11:13 -0800 (PST)
X-Received: by 2002:a05:620a:7118:b0:93e:c12c:43ff with SMTP id
 af79cd13be357-949bac8120fmr3189898585a.76.1795633872772; 
 Wed, 25 Nov 2026 11:11:12 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8960068fsm206144875e9.4.2026.11.25.11.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 11:11:11 -0800 (PST)
Message-ID: <5cb298ce-7f9b-40fd-b553-879a567e78a5@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 20:11:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2?] system/memory: Invalidate TBs on ROM device
 mode switch
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, Elliot Berman <eberman@anduril.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261124182722.78535-1-philmd@oss.qualcomm.com>
 <awXxps0Z4PjS85DT@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <eecb8487-0fca-4028-823d-f70215628f20@oss.qualcomm.com>
 <awbpz7SZ5grn9gyi@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <awbpz7SZ5grn9gyi@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZkvJTH5q9ZqFOdckRo78ANCA2fDk-b65
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3NiBTYWx0ZWRfXyJ6o60UYBBL8
 tVsswaToQW6CMqHv/8GXqD4ve999nVJIzCGBeEmKysrk8yyGnfDvUhCaarkJsIZehtrhQ/kRt0r
 jLx2DxaOIdOwdqkhQoyqBLbeCa/r4kw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3NiBTYWx0ZWRfX4nMvcvP579ZS
 4Rob73acfoGa/tffX1vTLRukvQhiH7zGVMVErcjMrPo4zEpdp16jptubh5cTldz4KqXN3IrlL5n
 dFKTuGUJ0EOgAtM4Fm7LEUnK+QyLbbiimq1GJOj4R/mafTcQquXLxJ54rGphyVPt1LBIqpG3OTk
 PLunfZKrAAOhAraJKYLcQStWNJJoj/laxbn1LgV9QZpMQvhMGTDyanWZyDJZyo7WE+iNfxQLLrG
 KaEatbWM+/nHl2JcxxIU1LSgUTfHnvigJSwzhpBdoEesHa7GwNolrgdLr94MSl2QVlCrvl2fOMd
 jsQUMG6R1GrKh5pecCb3v0bBWSf7VPh/mkZi27R6fjWo5U1WymPLcQXeFQOZ3M4/IaJddQTQNsG
 +JwjeE5tL2/+QjZ9WPKI8cv4ykMyj14Q1/CRJm5rnwWaObXy4BDIpWscIc3vX15cRwzBmNU0oZ/
 tkOA8xK87UGKgqUnXcg==
X-Proofpoint-ORIG-GUID: ZkvJTH5q9ZqFOdckRo78ANCA2fDk-b65
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b0732d2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Vf4uZd1p9bgafI2oBYEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250076
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/26 14:59, Peter Xu wrote:
> On Tue, Nov 24, 2026 at 11:29:15PM +0100, Philippe Mathieu-Daudé wrote:
>> On 24/11/26 21:20, Peter Xu wrote:
>>> On Tue, Nov 24, 2026 at 07:27:22PM +0100, Philippe Mathieu-Daudé wrote:
>>>> A ROM device changes its contents with direct stores while in MMIO
>>>> mode. TCG does not see these stores, so translated blocks built from
>>>> the old contents survive the switch back to ROMD mode and the guest
>>>> executes stale code.
>>>>
>>>> Make memory_region_rom_device_set_romd() drop the TBs of the whole
>>>> region on both transitions: before leaving ROMD mode (if currently
>>>> in it), and after entering ROMD mode, for TBs another vCPU built
>>>> before its TLB was flushed.
>>>
>>> Pure question: should we flush once, but only when ROMD->MMIO?  Said that,
>>> IIUC we need to flush after switching to MMIO to avoid the race you
>>> mentioned, that is something like:
>>>
>>>     if (mr_is_romd(mr) && romd_mode) {
>>>         set_romd(false);
>>>         flush();
>>>     }
>>>
>>> It's based on my limited understanding / assumption that during MMIO state
>>> TCG won't be able to cache invalid TB on these regions.
>>>
>>> So when switching ROMD->MMIO, invalidated TBs can exist, hence flush only
>>> once, after updating romd=false.  When switching back from MMIO->ROMD, no
>>> chance caching anything wrong.
>>
>> This doesn't run. Its flush comes after romd is cleared, and
>> memory_region_flush_rom_device() asserts that the region is still in
>> romd mode. The reproducer aborts with:
>>
>> Assertion failed: (memory_region_is_romd(mr)), function
>> memory_region_flush_rom_device
> 
> IIUC that assertion was not required and can be removed, based on its
> comment?
> 
> So my pure question was really about why we need two TB flushes rather than
> one: the pflash changed causing stale TB which I can understand.  What I
> suggested was "making sure nobody caches this pflash, then drop all
> existing TB" approach, which requries removal of the assertion.  I assumed
> that works, but maybe not really - I tried to read slightly more into TCG
> just now and noticed maybe there's yet another layer of caching on TLB so
> the stale mapping can still be visible.  Said that, IMO it would be great
> if we can explain why two flushes are needed rather than one.  That means,
> if we think the 2nd flush guards everything somehow (including the stale
> TLB async work hasn't flushed), then it seems to me we can then drop the
> 1st flush (ROMD->MMIO switch).

Wow you are right, having the flush on entering romd, after the contents
are written, is what closes the window, and is enough!

-- >8 --
diff --git a/system/memory.c b/system/memory.c
index 2e3ce773ce97..8e11d42bedce 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2252,12 +2252,16 @@ void memory_region_set_nonvolatile(MemoryRegion 
*mr, bool nonvolatile)
  void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
  {
      if (mr->romd_mode == romd_mode) {
          return;
      }
      memory_region_transaction_begin();
      mr->romd_mode = romd_mode;
      memory_region_update_pending |= mr->enabled;
      memory_region_transaction_commit();
+    if (romd_mode) {
+        /* Drop TBs another vCPU built from the old contents, once 
written */
+        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
+    }
  }
---

Thanks a lot for the review!

