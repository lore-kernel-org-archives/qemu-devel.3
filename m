Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53481CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEXfB-0008KQ-Jo; Wed, 07 Oct 2026 15:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEXf4-0008JD-Ga
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:50:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEXf2-00009f-8C
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:50:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697JNq3w532528
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 19:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cWOIsz5HcI7ulNcjBrnIVjeK8Pfiw2Iowd25+PmhSkU=; b=fVEePjob4JzM8RoJ
 RLFNvgJnRN/AEe5e9eeGOYhA5ALV+Vpr2gz3jTNLHAlEVLhh86wv2Sv5xu3RXdxS
 zFS83cehWT+qHk/Wel+DKmS6Wd3J6s60QYuyYny4ipsaorHJQ6Kt/fngWwLX3a3f
 b4HrxQ/Hz6m2XFFk8hZCZbrcaiBC4fzEu0Wl1T5Y0KBG3ukO3uaZgV5m3Gvz8zmL
 qW+DhW6oIW/sXnLdOGQ9T0E0Tv5WHzvcCieT4NaYe28fWFYd/BQL4s8Zrznb/CLR
 iSIu/5TNZrddoCD8jrkCifEm2llI1lkKawmPNQM+Sh04LOIJwcqqXARMhS2Vk5ZI
 7Kgwbg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5mgra6yg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 19:50:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e834ff4d0so742776985a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791402642; x=1792007442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cWOIsz5HcI7ulNcjBrnIVjeK8Pfiw2Iowd25+PmhSkU=;
 b=IIl8oarGDzLsMFNkiH6NJVTHgD41HFjUTAORDEof9PKfXj5GKI7huIkMo3GlMEoFs/
 uoAf/dHquXEpunR6AmisthdnG+JWX85XFj1hMhrmvdCU0ldjcEuvvcTBialJr+exKjNn
 5gXdMou75uOb1nab9Piy1EqPLrCoU+ZMeIwgsoh6sWbHQrBrVHodPbd0gzzHQMPNZiS5
 y4GF1N7ntj1drzM7k5keMcxqrOpokhbtB9rutFo3DrImtyjuCO74mWBXKcJZ36M40S/J
 r3tp+lhz2950gUlIf2chr0VPe+gLyDHKgGtcPIF3lY8SK9PlODbwarNTkEb8CuGWuAaC
 g8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791402642; x=1792007442;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cWOIsz5HcI7ulNcjBrnIVjeK8Pfiw2Iowd25+PmhSkU=;
 b=WgbQ1vdHfHGtaB/f9ed4AFQvTgZumnY7FOOUTxsqKBo1vk5e1zny8Tr/aRKPNbaNUt
 LEn/oH6C6a9SgsER3BHF0dFcPpSzaZLxuXtwfWIYDg9pX/tbzLA544ywZd46wGfeXFNQ
 sEG7ifHLuntS3K4Bj8RJFtYzURSz/lHQ1mwAwGkdXm/6553b7MpJ65N6vWP1UzR5PSrn
 aoY8mWqkP3LcbN4yr7umvUMui8QAXSl6UfX9QFlUJBxsNoedjMX0qCn09D5sr5zsxEgM
 7eEL4e1GGJNJ4PXvAw87JwfBH+bcadYbBzWluyg6i/gjGIcyzhpvo1zugoaSt7ctPP8V
 JJTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoLxxDKHz571iIca4j13JNNrG+fZKCw3d1ljpBWbhfYyJhLUncAoWEjkLsKhbcdrX7nByz/lxreLiA@nongnu.org
X-Gm-Message-State: AFuF++kpqiMPhciOQFZaYazK5ZyWXMLcnJpTyo5esrTL8QmvJLvub21q
 4ND7+aR7aDjuYeK6Ls+FBL9wpbcMwB4FU9ipK0uhkXMwq9h0XGuQYg4NXpSTOnzcCCtfchomoYM
 PJKwakCd8Zii4KMHx/Rbr3jn3IpVnUdsvkfDVzkOXB3WX7qTFpPuiudzyPw==
X-Gm-Gg: AYBFou2VDjNnVPItWEktAokm6RKc9zqvzeqDGQEYzR3jv+T7R5lcWbK89rOl/JHMLim
 mW//bNuXv1Zwd3HynwVEgWQ6jGVEkT1Z+fzlEKojV4hfLjHNgvixEPOZh0I4LpoGeHQsXOq11xp
 tkcfDRon6xeWtWEOO3u8yF4i2HaWmPw75jvUNfHcGCzSo7BGBjU2eZprcbsj7JJutysnqXj2SF6
 lIVJbyO31+7l37ZN34FXIyHPsFct7OqKppaipeU03Eu4QULg1jJKoDibbIw9WVuKRNcYv+wHZRs
 3LduqpSYJ5LznNaZSl02OG7vOQitpw6WgNld0X4Cpa7iybpLa5ODgM98h/B/rK9P+qfoNM/gYXb
 XCPHXz5vnscxvWXiOljqK
X-Received: by 2002:a05:620a:4555:b0:93b:bc51:b40 with SMTP id
 af79cd13be357-93e9b2ec13fmr618376885a.2.1791402641678; 
 Wed, 07 Oct 2026 12:50:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4555:b0:93b:bc51:b40 with SMTP id
 af79cd13be357-93e9b2ec13fmr618372685a.2.1791402641203; 
 Wed, 07 Oct 2026 12:50:41 -0700 (PDT)
Received: from [10.251.42.73] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c317c37e400sm138903166b.87.2026.10.07.12.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 12:50:40 -0700 (PDT)
Message-ID: <478c0311-b31e-4d38-af65-79508fca3021@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 21:50:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/hvf: Retry RAM write faults only for dirty
 logging
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 "Scott J . Goldman" <scottjgo@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-stable@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20261007093001.74476-1-philmd@oss.qualcomm.com>
 <f0c07762-c115-41a0-b713-a47bdaa1f218@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f0c07762-c115-41a0-b713-a47bdaa1f218@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3OSBTYWx0ZWRfX0QTaPD+Z/xTm
 KcuBedneG823FX2negg3HQNCtZbwwXavK7QqQOKwMhX2CgKZh2KqAQRZopZwKaprwJ1N6/UBuhM
 2XVs6cTyl+fAhHNhRLn5DNO+p4uPfRykOhiuGdIkmz16qrHU5XdzcSm7g9wwn4iVGucC0TEg4vf
 WUsE6n5CX2bEuDmbVMJn0ha2MrnrtNhAVw0oIGXzxaCq+wCGwpQQKX34R0Ir9Wy46eKs5mm8wka
 2NCnvi6iIcVpy13Io720QdBgTGpcX4ROvGo4BlIZkoGPYS7XPORMdvEeFx4e1lY/B3MZmgv1mK+
 rzFuR8lxpBZEp9zwXqhAy8Zuea2Ocv1wai0h3X7ZX3oFYUXFXc07Y21GCvpTF+w2moqtuyw2Glt
 5AhsqLjOhJWCMm2OvJxoN5hTOqwoO9IGgs5WnXOHdRSXwPrmXeA8bPZNynO0j3s5YbUjKN2pNfM
 /YXmppGvC8BdXCO+Z7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3OSBTYWx0ZWRfX1huhoTBtOgjq
 7dbFFeQOf8QcNNnEtDAcThunfpMHxTPe101Srwu1bG72L8nhPrxBaz6DZrAFUJhXfwGR+3M+qhQ
 +j6Y3L1CO1yL8WxBvc/JbT9JPqUulVg=
X-Proofpoint-ORIG-GUID: qNxeLs6uuwhlxaapvEmM6OclspIJcPBs
X-Proofpoint-GUID: qNxeLs6uuwhlxaapvEmM6OclspIJcPBs
X-Authority-Analysis: v=2.4 cv=OYkNnRTY c=1 sm=1 tr=0 ts=6ac6a292 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=kamiFkjBJaVRGB_CLxwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070079
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

On 2026-10-07 16:50, Akihiko Odaki wrote:
> On 2026/10/07 18:30, Philippe Mathieu-Daudé wrote:
>> From: Mark Burton <mburton@qti.qualcomm.com>
>>
>> Dirty-page logging handles a RAM write fault by marking the page dirty,
>> restoring write permission, and retrying the guest instruction.
>>
>> The handler also retried when the resolved RAM region had no dirty-log
>> client.  This path neither restores permission nor advances the PC, so
>> the instruction can repeatedly exit to QEMU.
>>
>> Retry only after marking the page dirty and restoring write permission.
>> Otherwise, use the existing emulation path to complete the access and
>> advance the guest PC.
> 
> I can identify three cases of RAM write faults. The existing code
> handles all three, but this patch breaks the third:
> 
> 1. The RAM is read-only. assert(!mr->readonly) trips in this case.
> 
> 2. Dirty logging is enabled. The vCPU marks the page dirty, restores
>     write permission, and retries the write.
> 
> 3. Dirty logging is enabled when the fault occurs, but another thread
>     disables it before the vCPU acquires the BQL. The vCPU then observes
>     a zero dirty-log mask. The write still needs to be retried because
>     write permission has already been restored. The existing code does
>     this correctly, but this patch falls through to emulation instead.
> 
> This patch is useful only if there is another case that the existing
> code does not handle correctly. Please describe that case and preserve
> the retry behavior in case 3.
Thanks for the deep review.

The reporter said:

   We reproduced is a level-2 translation fault, DFSC 0x06, on a
   dynamic DMI RAM leaf that has no corresponding HVF mapping.
   address_space_translate() resolves the leaf as RAM, but the dirty-log
   mask is zero, no page is marked or unprotected, and the unconditional
   retry makes no progress.

That would be another case:

   4. FlatView says RAM, but HVF has no mapping (nothing has changed
      to make retry succeed).

So to prevent retrying a known translation miss that cannot make any
progress checking DFSC could be sufficient:

-- >8 --
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b00a7e1a84..4faa21caa1 100644
      case EC_DATAABORT: {
          bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
          bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
          bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
          bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
          uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
          uint32_t len = 1 << sas;
          uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
          uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
+        uint32_t fsc = FIELD_EX32(syndrome, DABORT_ISS, DFSC);
+        bool l2_translation_fault = fsc == 0b000110;
          uint64_t val = 0;
          uint64_t ipa = excp->physical_address;
          AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);

          trace_hvf_data_abort(excp->virtual_address, ipa, isv,
                               iswrite, s1ptw, len, srt);

          if (cm) {
              /* We don't cache MMIO regions */
              advance_pc = true;
              break;
          }

          /* Handle dirty page logging for ram. */
          if (iswrite) {
              hwaddr xlat;
              MemoryRegion *mr = address_space_translate(as, ipa, &xlat,
                                                         NULL, true,
  
MEMTXATTRS_UNSPECIFIED);
-            if (memory_region_is_ram(mr)) {
+            if (memory_region_is_ram(mr) && !s1ptw && 
!l2_translation_fault) {
                  uintptr_t page_size = qemu_real_host_page_size();
                  intptr_t page_mask = -(intptr_t)page_size;
                  uint64_t ipa_page = ipa & page_mask;

                  /* TODO: Inject exception to the guest. */
                  assert(!mr->readonly);

                  if (memory_region_get_dirty_log_mask(mr)) {
                      memory_region_set_dirty(mr, xlat, page_size);
                      hvf_unprotect_dirty_range(ipa_page, page_size);
                  }

                  /* Retry with page writes enabled. */
                  break;
              }
          }

          /*
           * TODO: If s1ptw, this is an error in the guest os page tables.
           * Inject the exception into the guest.
           */
          assert(!s1ptw);
---
(the !s1ptw guard is independent of the zero-mask race,
  this is to ensure we cannot accidentally take the dirty-log retry
  path when the page-table memory is RAM).

But be wary because I'm way out of area of understanding here...

Anyway I asked the reporter for more info and possible reproducer;
and might add comments to the code to better follow the 1/2/3/4 paths.
But after some sleep :)

