Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB8DCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxL9-0007Ad-PG; Wed, 30 Sep 2026 12:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxL7-0007AV-Da
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:39:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxL4-0002HW-6c
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:39:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UEvY29274512
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7BkwogiApV9wlzlGtc4IrZY2t3q8UPRTE80TxrMnmM4=; b=gQFkrBcNEKWTxXNL
 cKTqscAWLPvuMXyEfBoghX+hVIvMx6s63gqbRl3EmvHH0lEL61E12v8UB27i8Jjr
 FhHDP7+WKYkoyaiWnnKk2+iS4PpP8ZJhE9HMEbIQ4TFq/ammePCB4e9VSqYUlinm
 WrLs9i3LrpBBnd8NBXK0ijLkKm/Oi/JDsua5PMHvTXMCYW9XLhkRLAvpT2eMMLTA
 fuWd26aSj4U7up3uOUfrnCcwFzLFr7rf46lGWPlb0IArkECwbHQDDIRY4l762yEi
 LYoH7zf4XtQKT8FkQaZ1QfWKQ4MwCVMff7c1Pyh1diPCNTM4wT1iyMPZnIv0yB4Z
 hTbCbw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n20g19-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:39:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936aa34873bso1028181985a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790786361; x=1791391161; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7BkwogiApV9wlzlGtc4IrZY2t3q8UPRTE80TxrMnmM4=;
 b=ShqhhWyiwsf3OQHs3mFhqICSBp9KLbfNYbYIVeCGf4JRXI1qyPF9RhSQQ22FCLe6C5
 tbS0x1CVK161FCG4vSXiHIbR+Mh9BlvQLsi0GZR6m5r/Qe1iS0vr0uuGKqzdbuSi23MG
 CjEDb2Xkl4n+Eic9tjm+BqYu+XOiQB5FdaaIX4Sj9VbZZFtFV7X0RXOFMYZoSXFbRZAs
 kJSTtfhyagrtCkH8jcQPTzNptNIBY+E+d9+II62oqD464pW/gheU1wPoJlyTkbj51gUj
 CGVkPhEuM6x0X8cbitRYPXwz52YwXxxmwWTcUPph4M3GeTVtaQaxslPHzE1f3O/80J+z
 gXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786361; x=1791391161;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7BkwogiApV9wlzlGtc4IrZY2t3q8UPRTE80TxrMnmM4=;
 b=wGobRlvdhtTHp2rWYNY0C6jyTtw/cU832rWc0SIR2gW9V0YRZqeDEnhaAY3k2J3asx
 njpWgond6Wp0wjyERzwmEU95pIsaFAug7+jnf9UgZUZ5LsFS1nayVeClR1qFfKSCE9bc
 +2VVB14lf55TOazQ7vFOBLIou2eQ/+Jhu28AzVM5s8sYhKuISMrQzqs3QQv7H+wQ43aC
 27z36kAOdW6sg/YUUVbHEvXTZ6yRKn1eq26nM1oZce8bOcVBT4kuHHmOEKK9/fCy8EpG
 1Qm2Fl9B8R9MwDBmFv8mX53AsXWHuVnYShI3dWKTxeG7esWYn2OcyX214bLO+sHVdqg0
 Ek1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhdJk16eTGwiTr4d4eyJ8q3c0Qr21u0TGXZXpKMO//CNKFMvhSubupakfIR+qeh5vjFtdmnOXJ6BeS@nongnu.org
X-Gm-Message-State: AFuF++linSixsyyzB9GIGrIpYCMMweSnCn7+Wp/xwLdGxVOCHdy33coK
 ipQY6qL1MNzeUldYSj8jCp5qxrDLwkHB+Xjsvak8XzmRiIpSPqEXlS5sPSgk3Q3XyU/Ff51hpis
 23vgTvibyKXnmsrSNzqpFtQDnBRrDBsrj/cA6HmcdOaWi6wxBJf+EXFsQEg==
X-Gm-Gg: AYBFou0kz5CY8mcH3a8oIaXsy53+O+3m5I4vDQv7KilhTh06BILN5gSHptiWbyfUTED
 uuLuM6uRG1r76+kBQqmKizgd1nj+N8RQeEfl1uX/PAnIk0AJg3Dsi9rmJfHKlycqHJUN++PNZgk
 gJ+DKWPBhK8c+xPHpXYaN2ggobLFJLT7IUElt8GBcxDVvr5rxvzAvJkRfZuqsMwz0BpOny1qy0R
 ASWEVmUi6JjOb/blGd7NbE6fbCE8Y9HhIJwRmOsdTpNDHXyILdzIsyXuyfrrXOm81Q4aI5FJW+2
 u2cym4I+iXeeFXTcvF/JhW7klFgBNHaf9ElOATjLz5Sl9lNtCjZEqsgms5NapV3KcYmE7Npz1L7
 xSf7p68LOZYTF6b2KUQQ=
X-Received: by 2002:a05:620a:c42:b0:93b:d7a2:83cc with SMTP id
 af79cd13be357-93ca987a602mr349072185a.59.1790786360671; 
 Wed, 30 Sep 2026 09:39:20 -0700 (PDT)
X-Received: by 2002:a05:620a:c42:b0:93b:d7a2:83cc with SMTP id
 af79cd13be357-93ca987a602mr349065785a.59.1790786360016; 
 Wed, 30 Sep 2026 09:39:20 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ebadf30sm1896265e9.13.2026.09.30.09.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:39:19 -0700 (PDT)
Message-ID: <d19bd276-ec77-49ce-8ea5-2e079605a0e6@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/27] hw/usb/dev-smartcard-reader: release short bulk-in
 responses with xHCI
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <20260805-smartcard-fixes-v1-14-187ee9122441@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805-smartcard-fixes-v1-14-187ee9122441@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abd3b39 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Rr0CaZjiTvEpe9F_65YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX3WPXXeXiWLka
 hD77g4jvgizZAyZFDvr5Ll/FQPC/LnFYV6eJA2dguueGC+xPfip4/BIagUkEHz9gfvZvPvJwtyC
 x4xxVitvHTTXqHZvQMhc0uTO4O2pHps=
X-Proofpoint-GUID: 7f3-I9_GdMJxk3EIrDDiINWZmjR0hUW1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX3u8LStVl+mHV
 JCd9RwhfsY4g1Iijc/E5brG7pV6+NgB+ZRu4XuzrFcRM0kegpSykDronl9MD18ucaXK4gHtuW7W
 XMAcy4IeiOzfrYrwLjLJ+r3roZtRHdj+Bwy9HQ5C9ljcLHEVaIFA49TSXtud6irsBN2MY1ESQhb
 w0T2YlYMdUn2t7PEIMq4Q+b7z3OOlibar7MCVZKiopt4aw8Vg/n8Cdbx+I7kHT/4E8bM/z5m1SI
 AzIkeEVKhMt5Osc9RB5PeW+c5Uxz7ci3gil1xKa9VbK9DOcAPTlMRBLz/Cu8+SxmYU7/vG1SYMH
 hnlddx5wCj8vAXISu9p+wMETTJhHkX3IYUvoJGr4FCQfxti6muIy6SjJXlnUoLCG3NLqDK7LVOr
 2aczQQ7SIR2wDqZOSyOQzcSm7vretsyDLDDZbDoAL+L1M22q7gLW7RgrfUnN5uiza7DWZpg5AFr
 xUqXXfvfCkTzUX8rnCA==
X-Proofpoint-ORIG-GUID: 7f3-I9_GdMJxk3EIrDDiINWZmjR0hUW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300066
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

On 2026-08-05 13:51, Marc-AndrÃ© Lureau wrote:
> USBPacket describes the host controller's complete transfer request, not
> necessarily one packet on the USB wire. xHCI maps the buffers from all
> TRBs in a transfer descriptor into a single USBPacket, so p->iov.size
> can be much larger than the CCID bulk endpoint's 64-byte wMaxPacketSize.
> 
> The smartcard reader kept a completed bulk-in response queued whenever
> the last copied chunk was exactly 64 bytes. This is necessary when the
> guest requested exactly 64 bytes: the next IN request must receive a
> zero-length packet to mark the end of the response. It is wrong when
> xHCI supplied a larger buffer, however. In that case the 64-byte result
> is already short relative to the USBPacket and xHCI completes the TD.
> Keeping the response current leaves it waiting for a ZLP request which
> never arrives and prevents later smartcard responses from being
> delivered. Release an exact-64-byte response when it is shorter than the
> host controller request, while retaining it for a request of exactly one
> maximum-sized packet.
> 
> This fixes smartcard reader with xHCI.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/dev-smartcard-reader.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

