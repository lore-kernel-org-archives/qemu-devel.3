Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3F606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K7Wb7yqZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MixXKd4N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOxlI-0007R5-B9; Thu, 05 Nov 2026 08:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOxlH-0007Qv-3j
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:44:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOxlF-0004z9-45
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:44:14 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tj6R3532140
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 13:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GVwuJGOSSd4PSG+AhBSD2gAKksz0+mVzmJNet/LHkxs=; b=K7Wb7yqZMqxOJUMG
 5biaupBpK+KsZ4udPV73gKB3486pWKoiXmwCu0WeLgEF6cxBn31XftVg0oR7UdED
 q/ITZvQv0JdGULAuj7Ye6bdWGDQCBlbJ8aTiAffRQk17PYkAiFaArfOhwnmgXtjH
 BtOZq+F+BHtJDEhW7KG3DmSFWpJfBYpb1NmjhUqG7IJrBypzXUZDbJzsuezh0j9n
 u4J/pGUyoW2dGr+/77hYBph9O2kLle59oSkbPPRX2aOMvSW2ZtNzNNTyykktMRjO
 3JvHUopAV4ifwfbjRyQH71I75Nbj7A34IzCvYwESbIKlFLu33QGh81lVN+GQlL91
 RmpsIw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq9wp2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 13:44:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f13c143c8so361306985a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 05:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793886251; x=1794491051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GVwuJGOSSd4PSG+AhBSD2gAKksz0+mVzmJNet/LHkxs=;
 b=MixXKd4N0g+m2L8lyR70nKW6DiFcHQiaPj4+QxwaRKu0xR96PDZlThFPAa+z/F66uO
 gF6VzigXngTfb197yqjBGRKuu6nou49XDVB6fJ4QS4+GdFFs7WBn7mTnGyD92eCaMUvs
 ac9g7iN0/0Ss8dKLol6/SwpeEVrpIgdomB/02CfUmMMeL8YiXW54Tfk+ax6MMZ3WCfbo
 lj10UIsIPVOHVTVKHrE4Dbd5LjjOdqSMx4kteCb/PZu/FCLSyUEj4COiJIR1WgxBnWhL
 xYt3xAoeobo2RRMYuTO/XlV+wh3Jh/4SR+LHcLwcmualn83yXGgfqjx6cXjG0ONXE4sT
 TNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793886251; x=1794491051;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GVwuJGOSSd4PSG+AhBSD2gAKksz0+mVzmJNet/LHkxs=;
 b=UQSlV6FLmp+2E+Bo9C4kvM/G+ydDxU2jTUCcbn2PWr0yYL0v4ZK5oxMwSw1JhlxxXe
 7hpPTZ0to+CfJNTQxolHgBDEmcbOwiT28a+6rPUxR58Ky4z++SnJ3qhf1C0I6ZbW/yJk
 ghhC2oQWa2g2WBQt4K7gXNkFJjCGwSufaFEyFyrmpnohJkalOAhX/4wwWFeJFsr9v5U3
 4Y8RoDOYbQbgEIbTSwNu5H+vEik4MsrHPCSG58NYgOaynHeVJrJRLZYkVkS4+YzkAltc
 80pE1AnPWK9x72Pqt14uD/92mW4pwREHYhxloFYs89bpKW0EAQyCa0Shh2UmYe7GO313
 2Hpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwceQAIAa4yBoOWwkhJlXmqv2Tn+vnXd5I2h1hOc+I3QpRGM2GETGEkeXouhnHRDMYQlHaGeKX/Sq4f@nongnu.org
X-Gm-Message-State: APuU4Z+oWvw5UkiXaFq6BgTXsnLsDnf/GH5CcfZgKaGqcN1sQeEjyg1Y
 +N+4wuLMxELryxT5S2LGvX6D47CHQWmI06Xb2+n2YLfTYKKoQaoL87YFfs9UwA3kImxrdIzdXyj
 i0EC5/YxXuewr3JWJY/GNC1CBo/UepPl+L0L8ftg5P3nU5qw9N3o6uL55wA==
X-Gm-Gg: AYBFou2GtqXUUp73lZQL1N+fsoWaiTw/vNEdi2Bf1RR5N8IyEg+XequdnT21HRNMCjZ
 2Rstw6Udkf0RFYhaZhjnMS2VC0MiXZQmjI7+4DHTVYGxTKI224w09pGIVlsbDVoOykHw48csjWT
 fkbx3D1vXe8h1jlKlw9nk+XW4U+c69QtmM+O0Pw710OzZwaICX5vEohZ0m+GLaDUKtTBOR1D6cb
 loh4xxmJmPxiDZVcS0Khq8vKeM0bq5jtdwCFsHe6IsM7GK0QMd4y5c7TzAIKuSwjBto7NfIVmNX
 F5rWVU1nobl+EsbKM1ckHlWK3G5kOcQvtP2foFQi/HSbRF59cicTAVVhC6s16y1WQElF6QxX5vl
 ddQ8RBGLLUfsYRtWI/fMmOQvtZZgo8C8pWMVwr6CuxY2Vf+9D6RNaZftf+TobjYDSuKs9KSlinX
 b9g0dzN8ChLVdu
X-Received: by 2002:a05:620a:3183:b0:93f:26e7:844 with SMTP id
 af79cd13be357-944217942dfmr3131605085a.55.1793886250614; 
 Thu, 05 Nov 2026 05:44:10 -0800 (PST)
X-Received: by 2002:a05:620a:3183:b0:93f:26e7:844 with SMTP id
 af79cd13be357-944217942dfmr3131600485a.55.1793886250193; 
 Thu, 05 Nov 2026 05:44:10 -0800 (PST)
Received: from [10.53.234.112] (38.170.88.92.rev.sfr.net. [92.88.170.38])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b55abd3b67sm1871799a12.3.2026.11.05.05.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 05:44:09 -0800 (PST)
Message-ID: <b9960b3a-590b-442f-a95f-e21a24ee00ed@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 14:44:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mc146818rtc: Make PF independent of PIE
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Jason Thorpe <thorpej@me.com>
Cc: mst@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org
References: <20210619193849.27889-1-thorpej@me.com>
 <b9e20dbc-fa5f-1e37-ad8a-5d433d77c4b0@redhat.com>
 <00FB4F43-698C-4888-91E7-45FE80CCFC67@me.com>
 <bf3645bf-6a47-75f8-862a-7ea8c467f007@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <bf3645bf-6a47-75f8-862a-7ea8c467f007@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfXxyxKB27dKu+l
 zYISOq0ABhQJhzCxJ6Vqz7137Zfrh8sga0/1Vj8ReTzLcGmp7oqkoL2s/3Akc/0OIA6vYr+Hc/V
 VP6hB+gUkbBX5h0TRW+Iw5CYMFNdWACqHeJN5f7YDpwaxBW97SxXrj0fz7VdRh44nIIBkWGDPU4
 fOqTtFxB8CmcuAYlY3CTcIhdMQIDCtz29bgU12VRyx+Eh31J9pei5uL4z3jCZAlCSzRsX4p3qA7
 BJUqzR3LS1WoYaWw2eiYfusLKTfH93yebHmkNEBdnyNAu0fgycsg/pVfTTYYwG7Jzp99OpXpjqi
 5yUUZI39VajXusfWcEuGC4ucm8smIfG0XVtJ9Y+rS86/tIWz+NVJ0ftfjWjUfSSMttzQffh9vhh
 Em4qX52uFmhtFxzXYt603ysyeTGNyWaiuPFzGL0/0CQjkq1uQcaKrJO2/hiJNLYBv612CZ82ncx
 UPzIrwGIRjutwa+zG0A==
X-Proofpoint-ORIG-GUID: l8CppapKwVw6o4wb3QPVuRVQn5OX3AaI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfXwB4Hj2SW0CuG
 +5WfSigImnjmeflKF5q5NxEQXKq3VzauPZUdFp9Zc80vZUDlw42R9F8/lKw8U/U00gpPx/u7xPo
 mVU9VVr6Bqi6vIcTUP0tI6QF5rOdEFw=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec882b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=pXErc85JgWHKa/WMloIyLQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=jcp-bB7VmqDjS-7iV78A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: l8CppapKwVw6o4wb3QPVuRVQn5OX3AaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050054
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

On 25/6/21 00:09, Paolo Bonzini wrote:
> On 23/06/21 16:24, Jason Thorpe wrote:
>>> Second, the firmware could set a nonzero period, and this would cause
>>> continuous interruptions of the guest after the firmware stops, due to
>>> s->periodic_timer firing.  This is "optimized" by the bug that you are
>>> fixing.  To keep the optimization you could:
>>>
>>> - do the timer_mod in periodic_timer_update only if !PF || (PIE && 
>>> lost_tick_policy==SLEW)
>>>
>>> - in cmos_ioport_read, if !timer_pending(s->periodic_timer) call
>>>
>>>     periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
>>>                           s->period, true);
>>>
>>> to update s->next_periodic_time for the next tick and ensure PF will 
>>> be set.
>>
>> I might be missing some subtlety here, but by my reading of
>> periodic_timer_update(), either one of those changes would result in a
>> delay of the next latching of PF by however many ns the CPU was late in
>> reading PF since the last time it was latched  Please correct me if I’m
>> wrong about this!
> 
> No, it shouldn't.  I may be wrong, but the process is the following:
> 
> - the current rtc_clock value is stored in cur_clock
> 
> - because period_change is true, the delay between writing PF and 
> reading C is stored in lost_clock
> 
> - then the delay is compensated by next_irq_clock = cur_clock + period - 
> lost_clock

Indeed we skip the periodic timer entirely when PIE is clear,
so PF never latched with PIE=0.

The following (based on top of f29ccc287a6c) seems to fix it:

-- >8 --
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index ba396435d1af..6a60d4cf3673 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -132,10 +132,6 @@ static uint32_t 
rtc_periodic_clock_ticks(MC146818RtcState *s)
  {
      int period_code;

-    if (!(s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
-        return 0;
-     }
-
      period_code = s->cmos_data[RTC_REG_A] & 0x0f;

      return periodic_period_to_clock(period_code);
@@ -160,6 +156,12 @@ static void periodic_timer_update(MC146818RtcState 
*s, int64_t current_time,
          return;
      }

+    if (!(s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
+        (s->cmos_data[RTC_REG_C] & REG_C_PF)) {
+        timer_del(s->periodic_timer);
+        return;
+    }
+
      /* compute 32 khz clock */
      cur_clock =
          muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
@@ -192,7 +194,8 @@ static void periodic_timer_update(MC146818RtcState 
*s, int64_t current_time,
       *    to a shorter period, scale up the missing ticks since the
       *    OS handler will treat past delayed ticks as shorter.
       */
-    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
+    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW &&
+        (s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
          uint32_t old_irq_coalesced = s->irq_coalesced;

          lost_clock += old_irq_coalesced * old_period;
@@ -239,6 +242,8 @@ static void rtc_periodic_timer(void *opaque)
              }
          } else
              qemu_irq_raise(s->irq);
+    } else {
+        timer_del(s->periodic_timer);
      }
  }

@@ -700,6 +705,10 @@ static uint64_t cmos_ioport_read(void *opaque, 
hwaddr addr,
              if (ret & (REG_C_UF | REG_C_AF)) {
                  check_update_timer(s);
              }
+            if ((ret & REG_C_PF) && !(s->cmos_data[RTC_REG_B] & 
REG_B_PIE)) {
+                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
+                                      s->period, false);
+            }

              if(s->irq_coalesced &&
                      (s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
---

Jason, do you happen to still have your setup to test it?

> 
> The best way to confirm this would be by writing a testcase (there's 
> already an mc146818 suite in tests/qtest).
> 
> Paolo
> 
>> There exists software out there in the wild that depends on PF 
>> latching at regular intervals regardless if when the CPU reads, it, i.e.:
>>
>> PF          PF          PF          PF          PF          PF
>>      C            C                  C      C                  C
>>
>> -- thorpej
>>
>>
> 
> 


