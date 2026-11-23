Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B08C606A32D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b3pJpLcr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EeZkQlzJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVU4G-0007cq-BL; Mon, 23 Nov 2026 08:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVU4D-0007ZU-SO
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:26:46 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVU4C-0004AI-4L
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:26:45 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDKxWI2442797
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KC3s5rYFV2FvFX3dO3rp3tILyW0u+sqSzvYgake110U=; b=b3pJpLcrIsZ63fkL
 o3aPyZ+dltgWVrNlIhmcZ31kHgkPHm0pvkKGgTF4PFy1GbcUUqUC+vwVpr125R2E
 3pxeYJlkg8hEWkzqTB53zMpdEoVic4T5jZXrpPuDC+U981n34PAYJzxgW9X6IhFl
 PTbQLPeia3EQv4oZs4Pcx2Vv/22fJ9+TuBo4/JLTLrNpK1ScOOTK2M0ga+ktnKzN
 TLtxSTsNl78QUpDATlaeS2C4aJY9slfmCXfDLfQ2d/AaqDhMJWpA3OJUPqRkKvKg
 JuQbk1+YTXQHfXR9SlOnNuEmgyb1S1mxdnIfHqnGN5cvoJ0SOyR/30CikWcvIBDh
 3iVNsw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k1jag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:26:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94961ed97d6so587243185a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795440402; x=1796045202; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KC3s5rYFV2FvFX3dO3rp3tILyW0u+sqSzvYgake110U=;
 b=EeZkQlzJhXGNAhxHVFom6XBsMllCN10q0nrZQnYUAY6merm0i/sSjfmBctPpzF4xlS
 pvjBleNJiCDAyQoPvkSnR+vjMQm5RPkYizBVlFOyvkijoSWzo37ezk+gSpRH7fAiczju
 3kVtQQz7eNT0/hO8H5XXTLsuXFPcDdfV8LRtcTsweMVCTb4lXuDBpV89k4aD19ZwNRoG
 OyzKIfTCNZxmMd5B1CLlnFyT2yLspAX9QBKG3uqK1eMzDVCMxUbb0OPQPj8eMI0Od1XA
 1Lv4ekvpKbmaj81lwGbMtFGWOnLyf2XDcAgB/ILnki4Py6137ryviPh3fM95p5a8mw8i
 0+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795440402; x=1796045202;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KC3s5rYFV2FvFX3dO3rp3tILyW0u+sqSzvYgake110U=;
 b=2HqRCpHKTHqJAjwGQTMGtT/qkp85YbAsmZx1USPNeDoAw8d10664vCSV7Z1gYq6HVD
 tCs1TNn7Oi9b22KpOg9WWIF+UlH5kBIgu6iqizEwuh4TQA5ySmL1tgQn6PZAQKdj71eD
 JLon1tKAvWX0qpCn5CLIsHfkJaa803r7Ceg0PBZGD/i3ULVWvM6LJ3HDt6+ifYKCzomb
 CqigxQZw/5+lBwHnfk9PDfX27x5bC8l270mIZfjBAQR7nMsrHq/xe8HR9/KmjxUYKGea
 c2QBX8Ruwm9BbyxQQGwvDCvDWGfPplEMJmQGq96CjzcBuJhd3NclyGCj+LKxk/+tY0BJ
 rlrw==
X-Gm-Message-State: APuU4Z+uLaCz9loySMpbe1F1qYG1CnPg5GWm5/2l7tuptl02O34qKCJX
 rgHK0hLC5gCmHtCQF0KuDWkF6aCZs0CF0BIrg5aL9VcxFR5dHUcxt3cSE6Ueovh9bLrw6w0zmfu
 6DQsYxzTLXuJybumx1F80iBK2e/+0wrgMs9KOTMXYPf/w+bO+CzQWtTiTcg==
X-Gm-Gg: AZFdTZeILD/fRPU3LwCX4nV7hgV8EZj4R2Xl+vd8rGwEbt5hiBChC42NPHtZvubm3/x
 rnnPN9dKh43uva25O0CuY6D7dmUUGbk5F3Wj2TDBQ3fmEW5i/5W6P8Afag3NP/cjjdypcKghmbo
 cA3F38O4jiEWgdtWosovmsiH1i2Ley1j1fixoDrhDXFFl5JlGs+YmZ7dsktPx+GDKpMLGsOavm5
 JMvVNAM+3Hrn3fgAY+3OEA0BNp7BB4Gwyidq4mxcNz08HdHvjwU9h/h4+eVgIeFehH+k74ovzBL
 duzweVjWU8KotYCAGH0hF+03+gMrL1flOFmofyyRGXloEldl1GZyBLH1NywR9lPm2+ZoP1/+5HJ
 k+0ty+l8oR/O7SYRtwCmliC8y+zAU7akBReR+PIsUGGkAUWbMRCpbZUsJyxbN3gpummayrZWo/X
 wc3jX0eQw=
X-Received: by 2002:a05:620a:1a09:b0:93f:22af:ccdc with SMTP id
 af79cd13be357-949b340223bmr2025063085a.4.1795440401547; 
 Mon, 23 Nov 2026 05:26:41 -0800 (PST)
X-Received: by 2002:a05:620a:1a09:b0:93f:22af:ccdc with SMTP id
 af79cd13be357-949b340223bmr2025057885a.4.1795440400937; 
 Mon, 23 Nov 2026 05:26:40 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c4353d6sm21551477f8f.56.2026.11.23.05.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:26:40 -0800 (PST)
Message-ID: <47428c0f-34a5-4cb4-991a-e1d5d8bbdfd1@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:26:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git: Fix broken relative symlinks for Claude and Gemini
 skills
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20261123092817.1237214-1-zhenzhong.duan@intel.com>
 <awQNLBquRToihQJV@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <awQNLBquRToihQJV@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MyBTYWx0ZWRfX0LNAdipows7/
 gft5wR4MaRhFCmfX00ToJynzx4LEkwGoC48+X8V/xKUx2EOTlFflfNPvX/lPMMAy6oF55j0aFpu
 1dCFSCfIl3KgTD0V8An3roe2STt9Xdg=
X-Proofpoint-GUID: KqCdhKoObfTWSeU0Tv_UWcFO4eCGxK6w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MyBTYWx0ZWRfXzaSm1DLZSVVH
 VFA5dxU/8Foeiq+e5WX4SSY/XE3Nl96NFJGFNawfvQNzFa6oVrQ7AZTnj+DB5M/70aMxbAR80Os
 zzi5rFtQqOJ7WlZ7CtDIKAx0dS0E7GiMrVCAXlpVwUjzcwNBXVuw52troY4A/gt49w2xOO4YIs5
 3ZJclkOVIrl+ufWa/0oN1VWtMYEPEaS1ytzWuRDreh6+hD7Q0UAmoV7mldMY5s1HefGRhsTQijl
 G5+Ylv9OfB6bZYsJZYld+Pe+bRiuw6O/srB2QVZP4Sf4MzlxjiqqEdDq4x8a2hTdYT1iK815vfx
 JB0KkwF2EJ/z629fw+oJo7srXzVg0YrEPluMZZtbuJElJAyd0OcySxYYc3Nd9Vq4mC4SYC0cHHP
 Rhg7oVMOxpovzXKmqRrDCKWHhogpMO3rvPZC5euFGNaN3a5L5gPjrmpgjGTltOhhk+kRdPtlJNY
 WGQFU74EzuXFi2LEyjQ==
X-Proofpoint-ORIG-GUID: KqCdhKoObfTWSeU0Tv_UWcFO4eCGxK6w
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b043f12 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=mDV3o1hIAAAA:8 a=QyXUC8HyAAAA:8 a=ozEDvVbM4ILtxleedTQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230053
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

On 23/11/26 10:53, Daniel P. BerrangÃ© wrote:
> On Mon, Nov 23, 2026 at 05:28:17PM +0800, Zhenzhong Duan wrote:
>> Update the relative symlink targets for both ".claude/skills" and
>> ".gemini/skills" from ".agents/skills/" to "../.agents/skills".
>>
>> Fixes: 3e9fe057ae0b ("agents: Add a skill for finding your way around QEMU")
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   .claude/skills | 2 +-
>>   .gemini/skills | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> FYI, I've also sent the same fix several weeks ago
> 
> https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg02802.html

Can't we just remove these and let the generic .agents/ path?


