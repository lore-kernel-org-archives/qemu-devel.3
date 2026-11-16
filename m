Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C84D606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hvZSRz3i;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dzMzuqAK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT44d-0000Xo-1s; Mon, 16 Nov 2026 16:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT44Y-0000Tt-Mw
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:17:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT44X-0001IT-Ax
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:17:06 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfJnG3248636
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hYgYr5RFC/bP/OZaTf8t+JxegjDojK8SxFfxdH1Qyms=; b=hvZSRz3i7xWhfxHi
 5QirrCTR9xQ6aYfTk+ejaZ2CCyWKFsbiuxvRao3oeUZtt2y2sH4FByVEbN78y5Ro
 NGWcSWOSSFe6XtjgguFpbq41q2hllSl+JDxMzImEG1cZv+2fwb6qeWGrLNVulS8Z
 U7OtPgJPzANk0EUwLO54WxoyG0mdhb3uSW/PICd55FCZsEszD8h1DwTIpTp56Qiv
 Ar+X/lTUvu7i5iUJeVtFh2zT+6+W+gZB8QXSUFWFtZsYyCC2Y/lk74NvYONbNn8i
 TtYMfH/x/isGLhWe8bfQgn8Ri/lGa3jfROvgVZX70m5csMafohmbMWBaDKuwFPYE
 5PKmPQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j00nfjccq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:17:04 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1a5005fd0f8so5773673c88.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863823; x=1795468623; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hYgYr5RFC/bP/OZaTf8t+JxegjDojK8SxFfxdH1Qyms=;
 b=dzMzuqAKXICZSHoaspTmpyCyzvyqY9hWr/MFjr0SolUpwNxBPIWQZozbsc6bnoWVb8
 099o2erPHjliFGATUi8ayZtAytTcpdfzRpffJ4cjX0SbP7GiYCJ1zPMvkc2EcJw/K/ey
 M0rFD2BrqQiPRKBSm5SwBy4dBJJ0SR/kY581eD15IuVmvLJvrR0KQS2zwHfsAh+Hvn6e
 LAdC4VMUkf525MJ9/6Eg/4BthaGflX9UR1A4IlBm3r96AjwEC1h3QhsKCb2Gp2C7wkf0
 12unw5sjc4TAzujNAVkqcIbns3e6YnVLHKqU8vXr/Da0cmAT0QEJ2tqCMRYiA1iXRe29
 BePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863823; x=1795468623;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hYgYr5RFC/bP/OZaTf8t+JxegjDojK8SxFfxdH1Qyms=;
 b=pTtR9GMnrg/JFhYl4VujBQ/mpvlgprWcfSbtLu7SzGgcIb7Y+SrWWIrh4NDjoiacUA
 3DefPHABrYI/SQ1YvE4dG7RID1ZelDHsVg0gWhzqoFs/CpdMPV3SNM/vTPQRrVmvDcdr
 nONqTsV0e+zERTJ8DHGrOfN1+uZjIBan34/WUQJmbUFn+6rdxl5w6erVxbx+X/3pRQBq
 sq5J4UHpozZSnX+m73fVu46gkRrJL38bZXf/nOw2uvCUr/IEPWta+FfJ5bdkSNu+AK+4
 xdTSIeu1ukFZES8qbFPqrxcJYFl2P3jRD1r90+FKja/P8y3KAvdEp4nMYTNP+Bpt9kaf
 cbAw==
X-Forwarded-Encrypted: i=1;
 AL+hErHjXquAvyh+i8XlTkp7jvpduUakEzKKR3XJhBV0M1NMj802nFJubfnEX6oMcr2pwaddeLJM7SNEcwr0@nongnu.org
X-Gm-Message-State: APuU4Z94WFICadP0clwCBHTwLaIkrsOTjoxyEjIIIu+gNfkFUDWK3ljN
 i+h0+o/KkFc7+PWN+DPZDc8Tt7xZ9cp2iTlLfdPZPlLFazo4ysEh1hBb8+YHdghYGqm8EP3v+iz
 Dx3GBPOEdj1VVCcmKLo3UAsXosy2HrGMxW4Ff91d0LhdBKjaTuptL/gmI+8C5Hpx4Hw==
X-Gm-Gg: AYBFou1p92bmSLepgkiWOLaUdWibikS39ExgdtclrZ+ZXs8O+fFVJfOkm0c2ErlxkCq
 /t19ujdvJIklAjk8l1SmbA6YsnRetJRauR1CvdYk5zLpi6lJJzHnfDVhyFu77neb/hu4ywox8s2
 AbGxNtmdSJEPPGKzK1jYS+KWi3KAg4ZWlQ0OYWfY2xsMn1kBmrHD/oxatItu5hEXzsPF2OoWt2G
 1cFkoTc0LB/8VUWpwZwgnnrwq2AdTUQLhr2JPPmsl5yTnhwv5LWWBakd1JxDtguXNXV52WRMLM+
 ZIDX8vnCebkb8eQ/NhG/++/WzWoOE8dRVyppcmP62VrcVguTRFR+mBrz7xPyabQjYkAQ8tK/reN
 XudfLLCSuNcvUVE3onreG6m7C+Nssn09XyqK0mYbyboe/3MT+QcJ/HL9rpt762uq/2uhPVbggte
 ob6sQLfPa9Qw7hdLy037oJh1lWH52hCvxCAn1UTYI7wrM=
X-Received: by 2002:a05:701b:464d:b0:1b2:6d5b:36bc with SMTP id
 a92af1059eb24-1b5031753f8mr11604138c88.23.1794863823209; 
 Mon, 16 Nov 2026 13:17:03 -0800 (PST)
X-Received: by 2002:a05:701b:464d:b0:1b2:6d5b:36bc with SMTP id
 a92af1059eb24-1b5031753f8mr11604121c88.23.1794863822674; 
 Mon, 16 Nov 2026 13:17:02 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031bc518sm32799036c88.15.2026.11.16.13.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:17:02 -0800 (PST)
Message-ID: <00834723-fe27-415c-988f-45eec140cbc6@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:16:56 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/48] hw/loongarch: convert machines to use AliasedClass
 interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-17-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-17-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BrEIUoX5 c=1 sm=1 tr=0 ts=6afb72d0 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=mMSgPTiVsjVi-4WgDtAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX+qyC5o1zfPin
 pNTKlTWh6FZNZ6xCtCc/xbVhvT+d5DANapP+BCwT17bfnR/H9jv6crtn8KAD5lA3xu/M7IzJ0FA
 7KLhsk33cIS90iawe23yxn7SDH+OT3k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX3RhKBi5e5ceV
 YjOHTcC5Tt8YuZAtZoeeSffxzG5na9FA5NnKFEcu8IzZJMqVroi4lVHkKYaMKlaTpwq7/8NNi3k
 akKIs/PduNP1/r/o39ueYotVnDmyoUGgfkJ+tnMnT5bcE6CfU8vnwol69FkzLQoNb9Py00Pi2nP
 /3uOq2P4688XbzGDyoxCmcgcg9gOral/9qwQHRlAK+BPzFqATkPlIe/IIPdmaFmTu8oGh2XGpGv
 xrbnS/6S1I4ZQkPUqcb9DGxKMC2XaWHc1ovuqz6d1xnvOxN4fIau0r75vA0LplKMOXEVsphIUqF
 bRs5LAr6d6jfDV9RXhNPWZwT7xFXujJeiOBgaXQKQEP94BTT7RK12gI2lQabuOXOKzPZAYMCfXv
 IEBMGxkUdtU6+BFHT+5hYnNgOZpT7dUXk05L751YcwZhlWzeko7LGbUMdvgFt4AcR/ANsoNceXB
 UyIZh+cmd+vL83SiZog==
X-Proofpoint-ORIG-GUID: FqpB-SWz1ipQDp6mvCa1VKlUf_9fNf7P
X-Proofpoint-GUID: FqpB-SWz1ipQDp6mvCa1VKlUf_9fNf7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160084
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
> Stop setting 'alias' in the MachineClass and instead set
> 'aliases' in the AliasedClass.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/loongarch/virt.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

