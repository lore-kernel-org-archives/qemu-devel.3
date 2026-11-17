Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045C606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=POtRPXZR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y/4i9VvE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTRny-0002Be-HY; Tue, 17 Nov 2026 17:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTRnw-0002BU-Da
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:37:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTRnu-0006kV-P2
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:37:32 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMbSWF1487418
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nWD3TdtRi8CFtRGiFqzH5UXMrma1SaI6ByQbtVRquvw=; b=POtRPXZRUOvMeTA3
 Qsj2eM8VJYkhqxrIpi5jLiZk1efamz1Wox4SfapjElKyCU+tSG2FLfR31jRriL2w
 KlnEEOHq3fe9dAhJR3x0zx0BWmuiaMCJ2yfJSWIZA+jSIKhCJtIW9Ikxx2+iQvJ9
 AJpzvIiKea+Pucz7TjelanZ35X0jfZRfeLZOv9F3xT9tEaDM6wHhKBRyJmRp9eB/
 /54ItvBeS784es9mUl9NWsCmwhUbsmH6TOKvmu+meMgvUZVZoxeyWNq4GsmUg7dh
 Tkfw3rhrxZMzIlo5+FWKx8J/VV/wDIQoKhDLZihzg3JhqrPE3/4L/Hscmg2yf9pR
 xMKQ5A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8g03t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:37:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91b937ecbb4so4261616d6.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 14:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794955048; x=1795559848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nWD3TdtRi8CFtRGiFqzH5UXMrma1SaI6ByQbtVRquvw=;
 b=Y/4i9VvESeBUNRJQZJol/GaKzwVx8nEE+km5jjCWIOPxwK8j2Y4BliDJAq+Px82ziW
 7m8VxCfXw3/nB0lIM4vAhTGBBnKK95Rnb35JdQhJYOgreTT/eAUHmCvkFRWZ6KdMkpLs
 Hk34moktIw7WUiZkW6TVGaCMr0Ccfr+nPzB4GvJ/uBQZNBLXqrihcggatjdV2L+DyfHZ
 IQd4A7087PHhv4W9Jq+NJaSeZtcyQ5HEjjc+WFxgQBOxZR3AU3AfTS3o4UDHtb/5NZr2
 n2PvztFqPkP89HhYTpq0kIvScTRQtvCAZn1xkeLNCjQ/pNMS9H7Kzmm9BkbKV3gQwdX8
 8L9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794955048; x=1795559848;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nWD3TdtRi8CFtRGiFqzH5UXMrma1SaI6ByQbtVRquvw=;
 b=TfRgUoKnf3QOVkV7naw/CbebTBp/us6DfH30ytb8rd0/kpYI4ORsNcfFkGsKCDmRwF
 n7NXsX25hWyX2eUWcdRgfbu0seLW1F4KBftIsVvUXyDeZstcL8HMqBjlaHsmWBjjmSgg
 qbxbDyHKDOGsyctUyyLNraDO0vOCgJArpBfexiW74qeoybZ2BP/gASsiuN7+x0TsDioc
 DgJuF9wM2nGrjTcQAaJQe7UHyyU2nvGeVn/RcNfcY/IZ233y54s79eFaHgGpUXG8ekHz
 Tm3Nt7Q8sMCC/5Vc6qLd7MZ2W7DTIJtB5s8xYcY8TFE340OkP+uI/239cnT2JQxZTAr1
 kPZQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH3Ij9KSB/379o3jia7E6ipX+9u/UkG5ReZSMbww6XE3Crnlllqxdby+3kwwfG+uqjg2lEHSXzpMov6@nongnu.org
X-Gm-Message-State: APuU4Z8vQxYioeCnoUNda7uUj05QFadjafAjHW9w3UsSWtGraH/zqjWR
 YPNaXJdRnXrVtXexZdcI2gahE9iqJZiaFwJlwQDK7etARv4NYf2aJkkRl2VcN7f8p5Ngl/mOypA
 NK2C8sIrJSi30qJZN70WqnWmwxVkGTEb2yRLpo/6/hrpDTFZNLrCzFwTmQlGNxWScCg==
X-Gm-Gg: AYBFou3OZ6kTUoXVUNgxfOODruzf35b7qMG8S2Y05DCZgiA+0cO5qjk3o4edmQHjabN
 VN8a5h+v8U7/sfFG6tKjDoPBvxh9uEemB7lpnA2fLS5wsMFuqmZeagYK+WX4gAwIpthUVMIVunh
 a6XaLj4jF9ekDJI3z9bDZsaixM2gmXYzTjfrjgo0aFHSezS6axmdIoIkTZJKhHcb/hN53HDxuP1
 rZ8FSHkXFuiwiCcyo5R7gDXYBfWc5jjFt02y08oSi0/Iot/tjq5dn4ZBzcHmhMulLq23VwLH9K9
 yB5t79HVbuVfQJD2JfxUIg5iKLDUHzUXxeqBWcyL4ca3w0iDp1rjZGte6reAwHYOdD8mv0MS27u
 ncrAhlyXXmEYqccQd7x13MFLCmhCqmi77oNtUH7h+xmO62pCOq8ko72uFzS1YZE05AUH8uDT+pi
 lbE8d517U=
X-Received: by 2002:a05:620a:a0d6:20b0:949:9cf0:badd with SMTP id
 af79cd13be357-9499cf0d671mr18380485a.73.1794955047644; 
 Tue, 17 Nov 2026 14:37:27 -0800 (PST)
X-Received: by 2002:a05:620a:a0d6:20b0:949:9cf0:badd with SMTP id
 af79cd13be357-9499cf0d671mr18378185a.73.1794955047027; 
 Tue, 17 Nov 2026 14:37:27 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573baa9fsm1328599f8f.57.2026.11.17.14.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 14:37:26 -0800 (PST)
Message-ID: <c4eafbdd-e5ac-453b-afab-2f0a0fdddfe4@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 23:37:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/19] target/mips: Fix nanoMIPS BEQC16/BNEC16 corner cases
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-14-philmd@oss.qualcomm.com>
 <eea3dea3-5a85-4b9e-a74d-17f3d5c56296@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <eea3dea3-5a85-4b9e-a74d-17f3d5c56296@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IKYv4VZmrXnqfC5170NpGxIeadG9B_Nz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MCBTYWx0ZWRfXxIbLLeXlQQYA
 cJOrJl9dZYmQrKBUtCeCL5VYnab8oKfw25bkqwNOSOWW/YhBgCLb7Uf2DgRnkYr9nCv2CnA22qy
 1suG5fLHM19pU0syAHr1E9HRrhha2c0=
X-Authority-Analysis: v=2.4 cv=c60+0h9l c=1 sm=1 tr=0 ts=6afcd728 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=-VfCWUJZJeg5MFCRqNMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MCBTYWx0ZWRfX7ZmGgEJ6UE7L
 VXBLDgij3WiTWtc2OVDqbYjVIisuzbgHTId5FDC4qpD97BtpAHJirpvrNBSEy6B36inTI5Z54f9
 VZFSRhgY5/ABTXK95JFWVWHbT2qGt5uU5Cdekh/kEoCxrBOUZIB86ykp04rS0lhCG4kUJMiPeGi
 XC4Aiyt7SJJb5V1mQNKh9FKAM+gumjX7X1OXiV/0u4Uykljgmuzy6AZI/VlMDdW5wi/mPclyPS4
 KM2b5PH9f5RjGWtDiw+1oEUXTWMNelogswMgGGzfGooNjuoVyGO+oIwKiUKq3PdG6yJhoxzBFK7
 T6/PxEP5Ddk6FPafBNp69p8fA9gU5HPSIHYgJEb9XrDW1bimqztVcPaolyTvzYjfbxJxqcdmCCO
 sr6m7HkHichXKGq25vwRa8n0bKFQQAmAinGEE+KwHmmCIIMDQtMWmCAQXDWVp7X0JvfwbVdOrHQ
 wcpi3LAeLgwLrRaFOnA==
X-Proofpoint-ORIG-GUID: IKYv4VZmrXnqfC5170NpGxIeadG9B_Nz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170090
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/26 20:18, Richard Henderson wrote:
> On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
>> BNEC[16] with identical registers is never taken, so it is a NOP.
>> gen_compute_branch_nm() instead wrote $ra and skipped the next
>> 4 bytes as if it were a MIPS branch-and-link-likely.
>>
>> Also raise Reserved Instruction on NMS cores, where the 16-bit
>> forms are not available.
>>
>> Fixes: 764371d24c51 ("target/mips: Add emulation of nanoMIPS 16-bit 
>> branch")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/mips/tcg/nanomips_translate.c.inc | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/ 
>> tcg/nanomips_translate.c.inc
>> index f9dc573dbb01..25d57e75a0b0 100644
>> --- a/target/mips/tcg/nanomips_translate.c.inc
>> +++ b/target/mips/tcg/nanomips_translate.c.inc
>> @@ -4756,6 +4756,10 @@ static int decode_isa_nanomips(CPUMIPSState 
>> *env, DisasContext *ctx)
>>                   /* P16.BRI */
>>                   uint32_t opc = extract32(ctx->opcode, 4, 3) <
>>                                  extract32(ctx->opcode, 7, 3) ? 
>> OPC_BEQ : OPC_BNE;
>> +                check_nms(ctx);
>> +                if (rs == rt) {
>> +                    break;
>> +                }
>>                   gen_compute_branch_nm(ctx, opc, 2, rs, rt,
>>                                         extract32(ctx->opcode, 0, 4) 
>> << 1);
>>               }
> 
> Surely not.  BNE x,x is never taken, but BEQ x,x is.

Right... Updated as:

-                if (rs == rt) {
+                if (opc == OPC_BNE && rs == rt) {


