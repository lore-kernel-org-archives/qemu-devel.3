Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937F606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WktSAIrW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R0uHtjli
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaCW-0005gU-31; Wed, 21 Oct 2026 13:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaCU-0005gL-Ph
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 13:34:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaCT-0004TU-7b
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 13:34:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFTutj141299
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 17:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tn+f6UIbPtET9LQejauSjOCFqyHKmkSXKNsZOk0pWRs=; b=WktSAIrWgQJDSMWy
 3PBNL6isPus4vACSFpR9Q+QWk1DOACdAu+UhiXIWo5f+l5J7DUKZSgPrmrLZSZVt
 Qj27cACYGoYHSrIYtIf33+GzHBTRwZ46PMAQI8+HTiynJjYC1tpmEdxanxt6hKye
 atGbNsr96kDtLjegu6sMGw3xdzzYjosMUS3OhsEt7w6Jee0Hzom2Dz/0nv1JS0rE
 uKD6GJnggW8zSvjkuUNQnU+Nx/FeSviroMWDFHplNY3sA/uDQSwiD7ndIr+GHUae
 zeNcxHE5poJTVcXeTwPuWYDSO90ZTB3owiuyEVbuSQTATi55a8C9Jqc2W+QNyBzE
 UpncQQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5896x4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 17:34:03 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-151ba226e1bso1700040c88.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792604042; x=1793208842; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tn+f6UIbPtET9LQejauSjOCFqyHKmkSXKNsZOk0pWRs=;
 b=R0uHtjlifdWikUsVa5HoOgCbV/fzgG4/X7sn9ExfRJZMaHEuevD/CKYtEWsCzb18Nu
 1RSEaOy0qKxa2vsT1k1KO+xnDECCwqGMfRrS2r+7mXvrmt0OWb6SP8mcofDrDLyFs9P/
 6/ocW1nbUR6Ll6eQLBaJbvOUjpf+wg6/ChJSrRYJpericEVOCifr9hCo9GD7dY7Etk1W
 ByXY0bhfXM5S8F8mDuO7L2yWa0D+ISvBqY9justXxRx7mgedlW9Fh3xyZUK8po/gj58U
 TLf/rHQru8C1Zo9NJ/EgHvocoMriDKi3EpHJ926A3YSX1SnNj+xc0SY5e7IxVhSBZMij
 X/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604042; x=1793208842;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tn+f6UIbPtET9LQejauSjOCFqyHKmkSXKNsZOk0pWRs=;
 b=GmGgYNs4qJdtiWaVmykuYsZCuUThQE+urzOGN7TBD3oIWSiZgLcFGYb2OT54IwdXD9
 /eOdSe3h1oB/fuLuwNx8btuK0qZSHvdOpbAy1dAvfBPv7U/tSTv4FLrdXHx3vvjHCgmN
 0pchfqtaDoJYPbYZJF1X048fD5Qjonfvo/DjUP2apbT5M9r4U/Xxb+F8Sh1Pbu9qAMha
 rhRDmyk9+Y7lUnEHdUeoJ8TvjDnN9heq4R++R05LDEHAEgD5dnxc0OPYk0zb6l/577N1
 7gKk4RiZKlXQ+NKkX0c/sWI1iXH5L3RSUtsg9b+NGSW3Y+9mdCFaj+SFY76/wD1sWryN
 UW4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOHdLB5TvCLt/3TBtFkVH8X8j4rfDmfV9xGhK5FkNtnx9/0ZHPUYjARWcFsEL8xVUCn1uEXOTjxoAz@nongnu.org
X-Gm-Message-State: AFq9FYJyKjJ7PG7V3BpWNwGRZ8MMjAUsxN3TgkyWvRZ1hJjU0YuzZnyg
 T/llwECzvBM8hANY1dhHDG3Zhqp2jcLzQl/rwm12rMtl4CdcRwzKYQmO3+8ZAGgJgXmPw1t2YnH
 FpZe30ReOtdy3nVNbDFVoKlIB0MACYw1iKkwoz5e2i8IGtIwevauQqn+lbw==
X-Gm-Gg: AYBFou2y1IglV5FlpqYh8SCw7EuA2SAgBkXpRUctTMv9pOHAc6eZ00V2qwtanH10en9
 EsSN6eYuMBNvVd3bQ2xdkZDya3+JYNRjTqGCuWtzA44+/k3UJzhYz/AAcskr7uDmHkFiUhKjYKU
 SikXTtA4qdvRXYd54dLgInurz9TM0CTjmFwV5uOuV6/EaTFAiIdUAFaiC5w+4ashK15XP/PZTdL
 OzEFRVSbtJpu0qfuD6zMzAFrsSpDP+Tie3MW/FQM0IsPfnlXnYizoBY+2TsM5RCUYNgqrMvrQyX
 KDLFkNazUVShfcBNxDoRpVO3CYObJCJti25MPGaPVHaVZ7e4fAP0RV+REJNgQwWnR1ZBcsoV5MS
 vuoM+NOZImnO2RywcWJ6VXZT0LzyX3Lt83qDUs4O3/Ff+Pi3UFgMqhL34LsSFXupba9SB3w==
X-Received: by 2002:a05:7023:904:b0:14c:96a4:b631 with SMTP id
 a92af1059eb24-190a632f266mr3704595c88.30.1792604042466; 
 Wed, 21 Oct 2026 10:34:02 -0700 (PDT)
X-Received: by 2002:a05:7023:904:b0:14c:96a4:b631 with SMTP id
 a92af1059eb24-190a632f266mr3704543c88.30.1792604041848; 
 Wed, 21 Oct 2026 10:34:01 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903a180adasm7804889c88.8.2026.10.21.10.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 10:34:01 -0700 (PDT)
Message-ID: <ce551bd4-4ad4-48b5-a6a9-42343443cf26@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:34:00 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/21] include/qemu/typedefs: add ArchDumpInfo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
 <20261019212648.154493-4-pierrick.bouvier@oss.qualcomm.com>
 <0e39bf94-100c-476f-86c3-96bf86625c53@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0e39bf94-100c-476f-86c3-96bf86625c53@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2OSBTYWx0ZWRfX0RG2mzYgPyy0
 LWgf7W8arE9gvZ2nZ9uI40dvbAREIBGz2U3F1m36aGMwRIrg35r1aiQbUNxmWP2+xuZnUr6COW1
 lLmAqD/iCT+Vz5iKQ+zs7Jv5Pd+0kbs=
X-Proofpoint-GUID: _ZK4R053Rxt72QxxDG8zT11mXj5nabCj
X-Proofpoint-ORIG-GUID: _ZK4R053Rxt72QxxDG8zT11mXj5nabCj
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad8f78b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=gu9ENciLrnWOG3Jp90UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2OSBTYWx0ZWRfX3ZYIlnl4BzfT
 Pj9wkmGE5xrxBjX+2Cw2PNylv9pJPr32upwu6G3qUOSCf0qtDCYc+ziIbaZ52mb1aYtyDFITYte
 t/qfw/AqEam94MjuyEY88JI9m/vk83RgiP76xebPgh29YuxtBTOg4cfm5KbxSLWyI1xyzDYaCMM
 K/oGG2RjEKRPtBi+OeS8+polWlGbAFS61jbkqvJdliXS2RxkAT9HloFJPaweHcGl99yt0PT70GF
 LR14XOwK76jpIqNBt7sIWAkRx8gbWKbw2D3YIkRZsHjymsZykuNJr4CoANufinhezequJ1f6WMW
 hGui0PALIeMuYPa8ChaW5XJSFHCMEv1xNjbohvaj6kagmA3N8ZTWd5385+bE2Ds1HyVptV8pEFG
 dm7JWLPsn/Nsgf91CRHw09IpSg7J/SFySHaNYI74ZIS7dldTInxk+STTL+FPQJFWk+1uJJnm7ZR
 QdhgyhlQOLclozK/46g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210069
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 6:37 PM, Philippe Mathieu-Daudé wrote:
> On 19/10/26 23:26, Pierrick Bouvier wrote:
>> This allows to use a forward declaration instead of including
>> system/dump-arch.h.
>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/typedefs.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>> index 2344c92182e..8fa7f752dac 100644
>> --- a/include/qemu/typedefs.h
>> +++ b/include/qemu/typedefs.h
>> @@ -28,6 +28,7 @@ typedef struct AddressSpace AddressSpace;
>>   typedef struct AioContext AioContext;
>>   typedef struct Aml Aml;
>>   typedef struct ArchCPU ArchCPU;
>> +typedef struct ArchDumpInfo ArchDumpInfo;
>>   typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
>>   typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
>>   typedef struct BlockBackend BlockBackend;
> 
> Remove it of "system/dump-arch.h":
> 
> -- >8 --
> diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
> index 743916e46ca..7165a5bbd03 100644
> --- a/include/system/dump-arch.h
> +++ b/include/system/dump-arch.h
> @@ -14,7 +14,7 @@
>  #ifndef DUMP_ARCH_H
>  #define DUMP_ARCH_H
> 
> -typedef struct ArchDumpInfo {
> +struct ArchDumpInfo {
>      int d_machine;           /* Architecture */
>      int d_endian;            /* ELFDATA2LSB or ELFDATA2MSB */
>      int d_class;             /* ELFCLASS32 or ELFCLASS64 */
> @@ -25,7 +25,7 @@ typedef struct ArchDumpInfo {
>      uint64_t (*arch_sections_write_hdr_fn)(DumpState *s, uint8_t *buff);
>      int (*arch_sections_write_fn)(DumpState *s, uint8_t *buff);
>      void (*arch_cleanup_fn)(DumpState *s);
> -} ArchDumpInfo;
> +};
> 

done

>  struct GuestPhysBlockList; /* memory_mapping.h */
>  int cpu_get_dump_info(ArchDumpInfo *info,
> ---
> 
> With that:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

