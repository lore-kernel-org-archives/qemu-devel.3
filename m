Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D84CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC1x-0002Kq-Ef; Thu, 01 Oct 2026 04:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCC1v-0002K1-D0
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:20:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCC1t-0002Nl-Fc
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:20:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xnCh396316
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 08:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OsIV1SnUVG2R7nXEGhsBE5icN3BgEtHG2JfvqnnUsKg=; b=bqqR3cDMiidj4D9j
 MniidkpkNNLXfhtuivqBLZ/RaXML8iNMWEa19R6gVbYrv6WzxhQambng35OCbPkX
 wThy55YlYa3Bav8DqDgzOgT398RhD5apVHbr7ExJ6qZRYkbln1cD/Vqxup12JDON
 TCd1ypqYhTR73yf3MMaESg2F+6xs/hIpArxYPPDGBU+GlmEBpYJdG0ZybVvqj66H
 rbdMRgXxp8ElF2WKk8XBwxI3j0Qvh0rcd0d4ogdEnPCvvS09eWjEDylsnufYBQON
 wwHdksdxBh0JcIaxHeQBBp3PEkiMueXWWR7OilkH0IRZE69VoCjyZqguLL7nTI+L
 rv9ang==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh59rr8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 08:20:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a3f673221so1690772385a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790842834; x=1791447634; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OsIV1SnUVG2R7nXEGhsBE5icN3BgEtHG2JfvqnnUsKg=;
 b=erFYY7VOGo74yN9fop567Hz8GNUAawdKbve9vK7uCviv1jSCuvLqA7hFzvW/0cre3b
 FxBS2vQlWeHm8d829FAfZyY/Z0YNVyDM25j9tuAoJEX0PF57aThihfTo/l1lXRD+8pnF
 inLDrvcJKKlEqQx2KYvCatu+1ax61pz8gWap/bn0aXu2RZfa1km1oeG9WIrT0cSO30HC
 iObNRQkx5s+7qqwTHs4ABytZDvPT9i/uTHJaDKP9eCyDauPcNXl/RYDVP1S1Qhdo0NKm
 R3CSWGi6shYA9JGP79oilEPnexEBRFEuIVz0n+k3e3iv0xaKGN558TVeNm5V1jOukEZF
 gTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790842834; x=1791447634;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OsIV1SnUVG2R7nXEGhsBE5icN3BgEtHG2JfvqnnUsKg=;
 b=OFHqgMR0su4kkL8iKdNME+ryyEmPedTVbC41kuZEjbHQIULj1qGg7BWauQT3IlHu1j
 spyancct5gVcBK/t3sj3AgEfRO3p270+L+nHMwuBGROsLoQvyL9kOS+aBhG3vySQNhab
 m02DFIiwaHVUrGGBxdCqzHcVwGdTi7PI8XIxhO3/hMKWnhP5jckqSJkBTvye85cBnznc
 7uKwQFPZPwOwADp0vgTQyhCHRE3NhCNl8SPxxIrSPg1rig+USpUUGZydZXhySHer28Dd
 ScD9Ofk2778RDk5znCSbysaEZo+gUwcLnjxobgQyutsAgqmiebIFRGZEbXFGN09gzN0R
 k/1w==
X-Gm-Message-State: AFuF++kM2cCeG7drIvUmTuJQD7xM1PUYGj+eZaLmmyu6cLtwf8SDoR5y
 I2XhMv3QfuaR2Ekl17RjgkzkOFUgUdxl2cgkLH8JtygZzxRblJdf5yTTietGRWHxhbmg2iROZj8
 80kMiuyVrbD0Oz+vR57CkZfd6vSeS5ZyVmMbLB1F4ED2XpSouAeYCATHRFDC9DJC8+w==
X-Gm-Gg: AYBFou12pGLmiLcP0knewwrNtNPh/OKIUonPkY3/6UN//uBrJ0f2DMTuGCW2wT80irU
 8vFQcm6Ao4gciHk5IxcHtqV+l0tgVnBZwKdUrRfrnklfIlVo+qopt3RZgrSdvPS5mOGpo254vZC
 NfegVVWUZ0125WbpR9Yf7cKdsf7ZfGEfpbGVuqYcTOWeb7/mikC0C2AbJZllIFOqiAYl3bWArj4
 XYQ7YLAq1DLy7WQ5zIMoPaZKJaXNWO1RQ9nY0rm1F9fM4mqCGsCbeEPJlcBs19KBp2HI2AGgI22
 ILLdCW4gzGxdbQtKiRi8yCwpXLC1dlzVn2MXSbZvIabWY8R1nT+ByLDUhfCYVE5SyeiZtpJSm55
 d+hzTIXKzJTa5oSyourRRuh0+HR4NU/PRyg==
X-Received: by 2002:a05:620a:1b99:b0:939:3a81:326 with SMTP id
 af79cd13be357-93ca9725df6mr753303185a.37.1790842834456; 
 Thu, 01 Oct 2026 01:20:34 -0700 (PDT)
X-Received: by 2002:a05:620a:1b99:b0:939:3a81:326 with SMTP id
 af79cd13be357-93ca9725df6mr753300985a.37.1790842834010; 
 Thu, 01 Oct 2026 01:20:34 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f979c05sm82534465e9.3.2026.10.01.01.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 01:20:33 -0700 (PDT)
Message-ID: <619e0b71-d58b-44ac-adc9-7a5d8f62f716@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 10:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] accel/tcg: Make halt-to-exec transition explicit
 and remove cpu_exec_halt
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-arm@nongnu.org
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930174946.82195-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMyBTYWx0ZWRfX3IiI+GglkQox
 8T0mddfJGHdeEVeWjU/Phu8AG5HgLCmo2BhOuMKEeJnyWj509P6zI7mXXyu44dDrJkLEHJ+oqjb
 walOkKac0ijBTqN4rhFHwSjR5rH24nqezFWzalQsPeJfC0kd32t3MiE6fQHpvYVTo7mc3B4FO1m
 /+tiWx08w3betoJchPYurrFdWJuWIo3pKp3c37FqEA576MD+t4MM/+Sw/sL6bHYQaeEXZIrH38S
 bFECiJE1qsf4PAagpIHwMcJ1UzAbH+7Qk8bvv/0zsOdaw/N5zM4TdWp/qK/3nR/8igmQp0z1U5n
 +rwp6gESeA8bJGFex5pmCYSU5VPGCP35V6WgdXJXXwePtyI1HL7vPgXaHGK/2FJUsau641+SY8K
 Aac/ggvJtakL+P57I4o/Zkx59SNIGeaMcuCLyymhQ81N2maC9s7ztrZQKFKzhGR/jT/Tw/WBky+
 LlCHBlsV11EDRzzezeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMyBTYWx0ZWRfXyjdQeY93Y7gC
 ezpS90T6z6+iF8qu5gYjjXBP3qozNcyol8/WSvEzNnx7/hmgLa3Iw7Cq57d9ofDhJT8LKQRPnhB
 pvdJOPxUv+NWhnrTDUIcG9DXtIL0BOw=
X-Proofpoint-ORIG-GUID: dnVNElBW2wE7TxMgfjL2GC4dj6AGCtSC
X-Proofpoint-GUID: dnVNElBW2wE7TxMgfjL2GC4dj6AGCtSC
X-Authority-Analysis: v=2.4 cv=NrJE4MdJ c=1 sm=1 tr=0 ts=6abe17d3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JKmM5Wr0875lQbMBMLAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010033
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/9/26 19:49, Philippe Mathieu-DaudÃ© wrote:
> Missing review: 9
> 
> Since v3:
> - Rebased (s390x, x86 and some ARM patches merged)
> - RISC-V posted separately as [1]
> - Better describe ARM PSCI power-state update issue


> [1] https://lore.kernel.org/qemu-devel/20260930174508.81497-1-philmd@oss.qualcomm.com/

> Philippe Mathieu-Daudé (9):
>    accel/tcg: Refactor poll-while-halted flow in cpu_exec()
>    accel/tcg: Introduce poll_during_halt() and leaving_halt()
>    target/arm: Split leaving-halt handling from arm_cpu_exec_halt()
>    target/arm: Convert cpu_exec_halt() to leaving_halt()
>    target/i386: Split APIC polling from x86_cpu_exec_halt()
>    target/i386: Split leaving-halt handling from x86_cpu_exec_halt()
>    target/i386: Use generic halt transition handlers
>    accel/tcg: Remove the redundant cpu_exec_halt() hook

Since Alistair queued the prerequisite patches [1], I'm directly
queuing the reviewed patches 1-8 via accel-next tree.

>    target/arm: Kick vCPU after updating PSCI power state

I might repost this single one (arm specific) later when the
rest landed in /master.

Thanks,

Phil.

