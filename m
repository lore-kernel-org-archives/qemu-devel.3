Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDDDC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2D1I-0004TQ-2K; Thu, 03 Sep 2026 15:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2D1F-0004Su-SM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:22:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2D1D-0000bO-OI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:22:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2pMP1698687
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6gBYPeXv9nG7a2/rvuXBlAT5yzpZJInmbddeBkj/H8A=; b=Hkb/msyu/QMCJGTf
 o2I2T/IBfH5tlkpuPiTrAMpB3mh6cgrHoQEhEV8a3LMNA+nDaKPeqZfKhVZuYHKv
 pBJUnhOYIUEmLM9sV2jXKekpqJqYtF/mpaeplhPsEj/4qmDctcoCJdTBqcEHBb7J
 tpNpHjNpx1MZFrJc7FAqy8GP99P0jAqDEh1E1e4UGcEguu+5LmE2cN8b8rrMuRwu
 ZyZZtoxV64fS9cUUOIF4DMVa2aXVpollUaUX21T5B1BTXBJWUnu0ghkQ/Fg2gen2
 gMHlIS8q084e2uNYnoCRmc+kw824+/CLCIHOVnPpJqH+byuVqz9afLVRKsOGhOH5
 lX9nvg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfbyvh2fr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:22:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so30031885a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788463355; x=1789068155; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6gBYPeXv9nG7a2/rvuXBlAT5yzpZJInmbddeBkj/H8A=;
 b=C6Y6XQVkzURSiV/V96fj/e0Fyl1VMZnuPpODmuO5fwv/sZm6rE7QbQcgXc/dDqAPe3
 HrYNWy55/dcRiZu1Ns27pcXmEy60NYh6hMWzzkJdDYNij4DRh4b9kWfu0t1qFcnhLC5L
 950LYp8ksseFRVj9eEICvTZS+IsXvP8CiAUzqTOsAL0iXMO7VMDN3HT8DYpq4bCr60bR
 JGNjZh3R/2YJI5KmhBvGtig1n5x44N+rPXJyQS/cNVT1rj//nSbnm79M/7+o/9FiVSIS
 x+UPexQFcyFqlX3bBKhCi4o0iCl8mZ6ciSrTRH9RFZXDXhjU5vpieC10OLwlb2cVQhNj
 uESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788463355; x=1789068155;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6gBYPeXv9nG7a2/rvuXBlAT5yzpZJInmbddeBkj/H8A=;
 b=MCpaQEdcSMLdIHwvzQywD6KGzYVXTkmFJbIqONlehJGiQvRwQs/x/oo1hEjiOPbuci
 AkbdwxqIBN5cqWL5mHxxWsOU1ku1yfM6fBwKoKExo3IECKtqK8sd5RVnO53UqSO3Qrq0
 UuFWi7ePLjZO6lu20llIex6JdQCwvvLahBaV7jcd2lVQL2IK1DCC+74AXcZ60lYDu53m
 nmmT5OSnK/emA4PFd3SqrZCCQv6dnAHqWnCh0FFJ7dKoFUpJnpgz7R/fcvw8Z95ShrZ8
 S0PxAZgwpZmx1520vjbTpZMoEU1/iqWprRNq6RMxTcRXKV89PNPwUKNYNiSwverY9OMA
 v83g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxarsHfxcCJXetm/XhppyD1paMty6RVrTMNKX3TWg6OVeY59yrezYh38aXLZ14A70nY+qIRZJ519kSf@nongnu.org
X-Gm-Message-State: AFuF++kLA5Fdb/mfEIhXLCgjfTSGYZlkxL6NFTsJYHU/NMHt9JgjdhNI
 901eJSEgjNsUSBFJ6QGkc5HWHnr6eZidVSg3KXOOpikJ9onIzLGi4eeNKXvaxeSgD1skf70p/UT
 fpMhymwru5RIFIVI6fwBHPhUk4rYIj7QZ1OnqwKpEQWN6LwLwYb3FZaNtzQ==
X-Gm-Gg: AYBFou2NAYhUm097zFQOmHdpgnQ6fApd9tV9yvY0jdX5CgeW4UbwbELKKViSF3bXdsh
 CNFf3hJdOLULbvTQmEBiZ5YGldlL6sanMVJuy4kaI6yuNk3lC31mbJ2VbnEfyPMnYmK3T6UT4Xx
 8aQwu02p4YeoL2+LVcb4iF7BegoTfc2aQeSUs1pm0X6rolz/83JYxAOlcXItm4u8/wac7nn1uUA
 4EiLl9+M1UOShpx0CAEggsIf2LPTuwxruTw4BJ8mGxHdxnBWvefC0Nk/EWxxaTtcpPMvzetLMZX
 vTNFO7opJLB3+32QidDKa/ZKctGNp6BT4kO3z6wAXvJH3Tr8dz/krAc400+Zfham4dSSExZ31We
 QFtzhCJAz/Jkp3Ciqoixx4lt6ns+mhbvWEA==
X-Received: by 2002:ae9:f815:0:b0:92e:7ba3:73e5 with SMTP id
 af79cd13be357-939804a4763mr65666885a.42.1788463354923; 
 Thu, 03 Sep 2026 12:22:34 -0700 (PDT)
X-Received: by 2002:ae9:f815:0:b0:92e:7ba3:73e5 with SMTP id
 af79cd13be357-939804a4763mr65660585a.42.1788463354327; 
 Thu, 03 Sep 2026 12:22:34 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm102732905e9.13.2026.09.03.12.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:22:28 -0700 (PDT)
Message-ID: <c213ee8c-2589-450e-b346-d01d8177e829@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 21:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: decode the DMA insts as unimp
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260903185832.3240775-1-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260903185832.3240775-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 98olTJwtejnfO4a4bd7OofyPIRXAar_G
X-Proofpoint-GUID: 98olTJwtejnfO4a4bd7OofyPIRXAar_G
X-Authority-Analysis: v=2.4 cv=C8vZDwP+ c=1 sm=1 tr=0 ts=6a99c8fc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OSBTYWx0ZWRfX5uwrLgbE1IO1
 rYoHQShDJoDrF65bux1SqniIlUfKwv7Q/pOdcrxfF2J1Og/gmQIDpkyCbwyW2Dy4Ct84L3ynRYn
 kI1MXZjL7wDYgIVh+FmC6h2VDzy5mGNfSRfnLlJpz4csAeCDUFMV/VEq5++ds4fV85NV1P9UsGD
 5iiyjcNPq6nkZYOduuiveDzsWCrg8g7UjUKNdgFnt+dpm77J0xC0TqojofQvpxAbFKZHJ0kq1ov
 ZjRyY2iBSCtYcbJ9ciNi78ny5XgTyG2HTM7CjMdQFrW1fVoY+TT9G4n8qjTf2SSJnLbm+lfvuyN
 U888z50zvKT5OJynUffwuwMVt0SvOiJhZWj7FumnY6O1FhsYnDs3tmRDqtnJ2849J+6f1fK+b6Y
 gnjDlF2IrHUvQXHOWbHff7S30KzPnmG3VAKalN1f+4wdeHQ8si4lkUm+LCcUoVnl7rpvCu3ReoS
 4SCOStH6bh915nFHkMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OSBTYWx0ZWRfXw5dwKi8OVsAg
 GiB6g7CkKKXsOssiorHKFu8zGqwOKhTKg9J09ZuEkNE347TMXyBr7hlQEGa5Q6DgkdN5kuj0cDr
 oWXGwIPhgS2zCdZUBSUpMVnXgynM1EI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030169
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/9/26 20:58, Brian Cain wrote:
> These instructions are used by some guest test cases during system
> initialization.  It's handy to unblock some tests for now and we'll
> follow up with a full implementation later.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/gen_tcg.h              | 28 +++++++++++++++++++++++++++
>   target/hexagon/genptr.c               |  1 +
>   target/hexagon/tag_rev_info.c.inc     | 10 ++++++++++
>   target/hexagon/imported/encode_pp.def | 11 +++++++++++
>   target/hexagon/imported/system.idef   | 11 +++++++++++
>   5 files changed, 61 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

