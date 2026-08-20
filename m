Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0A7C5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8a4-0007Sg-2y; Thu, 20 Aug 2026 15:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wx8a2-0007SX-Bp
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:37:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wx8a0-0006Wx-Sl
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:37:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJPR4034792
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I//IOV6jZxVpe5dHwvBMhtEXmO21WZX14c6/+0QRktM=; b=fTql6NnR5n+HTB57
 mbPwoug9UHVDCrFbbMPX67Er7PECybfGfhjcCWXhk6OlhDGJWKF/94rurn+q1KFg
 015JIn+Ybu2H5Ed4Rghg0RadCVHkL5WdOkro2GCb0sCIWXuXq93FtG5j4ZoW9/ft
 w8lNoCpAd5H52l3/Tm9P1W6uxFdbwotl3n30GL+DHqkVn91q8hhDpT5OMreG3lHu
 6989S9lcZYjozZpcKzKeGZWXhLa+9afEe4G1OPkbtnYUj2qh6N9S1LviO/9AfEy3
 1mijVtv5/DupjX2IW1XjPnJPSM5FB73+SPIYGTu9lcZTgp8u4IjZ7vg1iaE/eOIk
 gRSj1Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg1apqn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:37:35 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90a91f4c6f1so2235616d6.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787254655; x=1787859455; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I//IOV6jZxVpe5dHwvBMhtEXmO21WZX14c6/+0QRktM=;
 b=Vbz/BCwHyQetW8mKBsR1nhVdFUW00jrKkLugPu4p0Ul2MrOO28cjiavFVLvBAUhDcu
 EEbLK0Vib4l7o3muntLk01hQKvUMVJGVC/Uvj5ArilmnRgkuWD0hHO7qh+MOwLOB/Tkk
 SqAQ/UIiJ5t9mvv3rLg+WGgylLfp3uZlcyoTtIfq9fZNuz/7NR6rFsVf9JbF03zE4Zzf
 xYlwBCLvZ4VzQACOM8ij23H7qfBFuM//T16ksR9/ylEk9hzzC4pjbAM5P+sX6Irz93wp
 cnggNhvYBI/v4ncPwe3e1gWDCE39l4eE0fwqL+pwtBbRf5y0aMpu8obE2/v36Hqz8clu
 SqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787254655; x=1787859455;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I//IOV6jZxVpe5dHwvBMhtEXmO21WZX14c6/+0QRktM=;
 b=ShEg1SIsuf2+/fjVeKmtdw1Qc4nJtDCV7MgIyr5B6QgaWIeq2K4nowRW6ID/2FDDCb
 yd7O8nmrscl69A0Ky0GTmC6EfNa7bNdF1kjF4rmQzJS5xS0CJCJmwfB2pr+iazl8CQKy
 4Wnr+GCOfCDD8rgCdRR1fophZ/TN/5k0UO4VbO9qBDZZc3W1N6e65W6YY7aKRhLqf60N
 ZLk9QQMhQQDeHcuyEg7XAU4P/Tjkl1Mla5airHJOX7Y93+teaSag37x/ujAwzgi8BPFs
 Y4FhAaT+p7bndKUaZpa3hMCMGWuLkoWtLED0mxTQ4Xuok7+EklpGMKHJQaXGzaokGZ03
 0Wdw==
X-Gm-Message-State: AFuF++l+30euVbF/hdP6U+FzMKYnnaYfqjfXITqNTUnghVAnOMor5JXn
 es2rHLNGNETP5/9xCQF3tabd9mSVY6PgW1Q65jbNtJTtvOiQdn/qoBwf5eNL8ZXr/lzmCniOkqY
 D2+jF0fvqeUgkehQ8JDuzdeVF2KqxvrNZMwRIPR0cCPnJWUUO1TEOPUENrA==
X-Gm-Gg: AR+sD114a99l+nQKTAn+cPem6wrP93vJBONDh3Ig83zcNefnAYBmaMgb2pEGp3Powdg
 yFeBbjZxrGHkPRFUBq6bChg9Sj5djEd4IsFS4atqgLIOb94TYV3QsBtMNr9UaT+xQCAZ6Lhxk0+
 BtAAJPIyg4vO6Bfc0tQIFk9mMg+IVc4MpMHFMddrwWLAUnrTyfgUsmCJU3oVkrFyhfCDJcxqtzh
 nADWV3/oreIEhBZrXUACruj/kh18eRxJNeprTCq3RAsVNpOw8/cNz6a8wNloEGI9lhI/cp0iP3Q
 5qwuTnYpgZEe+5uSP9j0ANiCLn9lCXgmMRxtCTx+qheAgBCa78Z+2ceZuj5HXt/+kpqiQ2PMrbD
 PkDD1P6201XtgmRJKxXaQvTpjODBazxZvoX/gGlJdV8lBLsaYJO9KB8HFQOYxC1Ik
X-Received: by 2002:a05:6214:2d44:b0:8f0:3b98:d6af with SMTP id
 6a1803df08f44-90c80e57bd5mr6395086d6.26.1787254654967; 
 Thu, 20 Aug 2026 12:37:34 -0700 (PDT)
X-Received: by 2002:a05:6214:2d44:b0:8f0:3b98:d6af with SMTP id
 6a1803df08f44-90c80e57bd5mr6394146d6.26.1787254654255; 
 Thu, 20 Aug 2026 12:37:34 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2910f8sm45410246d6.31.2026.08.20.12.37.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 12:37:33 -0700 (PDT)
Message-ID: <8365fb76-56c0-40cf-bdee-d45b3cb8d241@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 14:37:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hexagon: fix HVX scatter/gather region-length
 check
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com
References: <20260819230939.466856-3-brian.cain@oss.qualcomm.com>
 <20260820153230.3136530-1-matheus.bernardino@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260820153230.3136530-1-matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XwU5ZhREzls337VnrvHsvw_el-wHNZSt
X-Authority-Analysis: v=2.4 cv=G7Is1dk5 c=1 sm=1 tr=0 ts=6a87577f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=fQ-Gg4eg8WyKH38RfSUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: XwU5ZhREzls337VnrvHsvw_el-wHNZSt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0NyBTYWx0ZWRfX6ral+r6YkO4k
 CWt1k19C6Fsr2zc/71G01MkJvBOzO/7Wmxqzi7JiRaQT5EL/ifNuJo97t7zDFPNJX2HlRlcDO+k
 7FpJ2CqUx5PphE6DxUipfSC7uN99Dtc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0NyBTYWx0ZWRfX+0bHXXkVvaBm
 ePGL6bCyse57NO2HxwyOPFLEvRqez5Thu+F0oEn6r1o5Dcv5NGE9vuhsW8FD39P9PWD4Y/J3lUg
 VKl7mG+HGGiA8SbYYhDlx262GJMfyhp8A5GxkWC4XSam3V6kPrzYZYcxNLAAT5vSForV8uM1g0k
 0AXXpihi6FvGIjJmqgeXu3EZJJuHdfDWj7NfDkmYtmOkT+qm8KpxRgoZQVRkqWoKJgi6+X2bdC4
 MLCl9hS9IDdidyh2HVc8EGYE17KjdfupTAmA6qem7w9A6P/lHm8SvZczu3GHCoFwScNiPu2jOCR
 tnFhDBBFQoL9kY3Ix1rEdNJVl3zCivGmUV6dMLUje2v+PO03nk4964OILf/M7g8ukaZ5rjT7Zzq
 19fX58e39sa21+/QoUhWFYnavz8w4NEuAB4h9wcl8ohDmztMhmDwtiG6fvXXy2PYS6zwiIBdRr5
 FlOZH2GFLE3lgVh8fmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200147
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


On 8/20/2026 10:32 AM, Matheus Tavares Bernardino wrote:
> On Wed, 19 Aug 2026 16:09:38 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> The region-length bounds check compared (EA + i0) <= (EA + LEN),
>> which reduces to i0 <= LEN and never actually depends on the region
>> base. This let vgather/vscatter keep elements whose offset was
>> beyond the declared region instead of dropping them. Compare the
>> offset to the region length directly instead.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/mmvec/macros.h | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
>> index 0ed35720eea..7ee6f5e62fb 100644
>> --- a/target/hexagon/mmvec/macros.h
>> +++ b/target/hexagon/mmvec/macros.h
>> @@ -170,11 +170,11 @@
>>       do { \
>>           int i0; \
>>           target_ulong va = EA; \
>> -        target_ulong va_high = EA + LEN; \
>>           uintptr_t ra = GETPC(); \
>>           int log_byte = 0; \
>> +        int in_region = (OFFSET) <= (LEN); \
>>           for (i0 = 0; i0 < ELEMENT_SIZE; i0++) { \
>> -            log_byte = ((va + i0) <= va_high) && QVAL; \
>> +            log_byte = in_region && QVAL; \
>>               uint8_t B; \
>>               B = cpu_ldub_data_ra(env, EA + i0, ra); \
>>               mmvec_set_byte(&env->tmp_VRegs[0], ELEMENT_SIZE * IDX + i0, B); \
> Should we also protect the memory load on what could be an out-of-bounds
> access?
>
>              uint8_t B = 0; \
>              if (log_byte) { \
>                  B = cpu_ldub_data_ra(env, va + i0, ra); \
>                  mmvec_set_byte(&env->tmp_VRegs[0], ELEMENT_SIZE * IDX + i0, B); \
>              } \

I will fix this.



