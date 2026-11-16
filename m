Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1D606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zg8QYF4s;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Epejud/y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Uv-0004rp-Db; Mon, 16 Nov 2026 16:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Ur-0004mB-Hs
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:44:17 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Uq-0003AU-6E
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:44:17 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfGhs2247110
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t9C5jnPTlJiTiyl4/f1CbsNkPCLSGcgrpYmjpi4odhA=; b=Zg8QYF4skXPdUP6N
 7K4Ix3Db8couxxM1oSSdj7IklmE0hZvKO/gM3rvyDcvoGJE3u0Upg3GZUqia8olx
 39QmyieXy8JBpYgcUTkEYmpuwbjUh9VByKQkuXM86ecQLUrU43/QvdDoGdiWILLP
 eg1/2JMnUJelt79wcYB+3rQd7CMzGgtgrowAtc3WlNZn6PLOUYGsF6aiFl95i+43
 2VB/+ZbLCc/WUPrpZQdJRTfIuUkKjDSNveJZVhM6qUGWChh+ZsQiTIaT28BpC6ni
 TUw1Jbbn/jn3JW7WHnETXVMjW1VWEU7vC5FnbYiRet5kStXdmuuND17MOJlEEKFX
 ZNuGuA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqyaq8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:44:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-37549877380so5270529eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794865454; x=1795470254; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t9C5jnPTlJiTiyl4/f1CbsNkPCLSGcgrpYmjpi4odhA=;
 b=Epejud/y/8FLMRdzrA88+XukcgpkC2a0FO2I6hnnTtDsngfPIrWTsbZegcyUom28kM
 S83MBnB1t9mJMTj+3pDxYHe3rUrTXeJmzfhAx9zivmYecrsF+FyvZO6zDsOIJTqhoX4p
 C86OL64ehCyMJ9Earp+p9MBROfRUQdQGUhSgTVt8rw1q8woFZWdYH/B/7jUISTkyugHo
 mDFU2MNVoo8TY2q60KCQTK4sWz/NjByH5CXGHFQSEKNH63EicmiCKUyNZhGAARecC4A4
 xFympcY6ZD1XR2Ld7eCxGc2fpYt4hOKdTb+znP4ydYjYSYn4RyrZyqWt4Vfthj4eZul5
 JGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865454; x=1795470254;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t9C5jnPTlJiTiyl4/f1CbsNkPCLSGcgrpYmjpi4odhA=;
 b=kqmT0YeX6MuBWcysbJgVYekWyzBbr1U9AnRc+bKGLK275h894QUvqnxF97mG47GiJV
 gZB2UZaWGACS33F9JiFB3Wlimfr0rRUUM3P8NySysApWn1l0CfhUmFIvU3i627/xc4+l
 iA6HbdDmvwp8i04JdstdD6WPmebrsNCdWdeZBtstNKRdI3SCiYohixWteDIbkgkPalp7
 FH+GxKjn60Avh/JQ/UXDbQGQ8ge+B4ZhT4YpA69zd9lWrQ4enRRmur1/5afamFg0Pa+A
 4n5KP0tTu0wid6IT6pR9gZ+U2qwOsWzM+nbusL/L96+DzuEFPOd/XaGMsrELK2fOHFhx
 yJOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEYktNSPwVIJbn9MOQTlFUQ4PIZCJ2bW4ch9A8M2C6UA4JYVvXblyVTxtrJXezv/JxnUx/SpF7D6hp4@nongnu.org
X-Gm-Message-State: APuU4Z8YEVEGYtYQwa/mvhY7hCd3Cml7pU2Ve2i9aTvbNa+51A1KUd+E
 TwrisOlHuidzUUIdtPzp9PdG5uQvjMd9/Ts3r2/Rjh0nSHnw550JBTZoaOBt2ZeCLE78p3QOf4L
 fA6iTm09tp2TkYR4pgftgeTmHRxKp0JGah/vFQy3Fw9kSPDQoAJ04/+jMkg==
X-Gm-Gg: AYBFou2WJY5y9ThaqSgWuB3+GVrcqHyjR+QCevXq6Okp5H8nd2LJNog0yPefUPLnpQk
 rlyAA5m3hCgtLAUkJ/H7V7ojvGSgr7Bl0z4YXELoEPLM+uFP74Y7/akMXW86RA4qTx1aKWoiOCI
 XlDjGiiFU7tOtAGC0XdhDADP6JPYugemGduy+wkTs0NPWQULiJF7kYbQXFb3TfjKpXFWqU3BddG
 3CEJT5pparQDwxZ86TKkzsBWyEU/nbjr/XU/TuID3VWBmAt0uyt8dDbxwCOcIgrdjLHQ6bAsIzl
 qa7jGcNvoVHtH/RAjqN4lFS27phoCt/TOodvdG0Cp4jaaYEX1ZopTmqS2tMorgB2IUSADazcsGu
 YoZjutbCGzD4FJq8vDhLROVOBYRPJO6bHKAjoPZ+ymX9H1Q2V/FbxVwCP671KYxfKpbR4yx79Sb
 7VCXNplNOGc6pvyDwErpbmSYMeloRcMNg3xbemyxo37h8=
X-Received: by 2002:a05:701b:2706:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1b50312144fmr10723853c88.29.1794865453933; 
 Mon, 16 Nov 2026 13:44:13 -0800 (PST)
X-Received: by 2002:a05:701b:2706:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1b50312144fmr10723830c88.29.1794865453248; 
 Mon, 16 Nov 2026 13:44:13 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b524049e0asm15520160c88.4.2026.11.16.13.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:44:12 -0800 (PST)
Message-ID: <2ea8c5be-abd6-471d-bd9b-18809e72dcde@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:44:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 44/48] Revert "target/riscv/tcg: restrict
 tcg-accel-riscv-cpu to riscv targets"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-45-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-45-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX8G+95qWsPmOz
 Cxa9narEaVQu0PLb85Q6fSCeZ+/MBHvdmmAOWCzMCPCapNJ4dj2brTtc13IfMIkazu/K7JJe8DX
 GZlwz1hzI6ZvDm1kayPCVF4qfVJqyWU=
X-Proofpoint-GUID: ayUF71zBKDjCjCmmIJZrpTd2uF7Jvboq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfXxqaBgT7vwPHc
 DIGkx4OLwmY0wDnezS7UWhCwD611QImbS0khiEXbL0xxJMgqv+8Xd9yV1dCsqJ3qJacUU424O5d
 yOQ6SkLALLPEUbvXOOfwFO/agS12DcaYTDtFiXx0sfcj420IV3Bozo3ervWOhbePodmbQXQizk1
 dn1heaTy8eIrjbGP6xY4hwvv3zK6a64TWlL0fNaCer1uVkz/Ml+biv5aPwgiYKNhTMiPwJHTdLw
 b5aA43uA31fZJB4zf96KazEdniQsc5HX1UpNN7bCj1p6HcNEdlzyEfigOtqxIzu7LdpI8PznTTK
 LN/MlAcDJwDlbz8L1R+Wu9S7luNmwOmj05a2Cw22MhxYCUMyOqFyEOM6pgOzIShc70VNreCIRC9
 j0kgHRjg0xJukvzi/ZS3AfGL6ZElhOHrc2MRWrlWGRi+MXPsD3zlOkRRlWvrFOmcb/bIP/QCbIF
 nl7HuOUEjM/AXEKJbRA==
X-Proofpoint-ORIG-GUID: ayUF71zBKDjCjCmmIJZrpTd2uF7Jvboq
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6afb792f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=EnuhjQ2chKAxP1XGzAcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160086
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> This reverts commit ec65e16fd2ba012d57b1bbfcfcd04c31c4111924.
> 
> The conditional registration is no longer required since the
> base class is now using a target independent name.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

