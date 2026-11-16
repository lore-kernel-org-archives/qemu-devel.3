Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C2606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eY1oLqNw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ck3Xo/Wg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4VO-00059a-Go; Mon, 16 Nov 2026 16:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4V7-00054q-9p
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:44:34 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4V5-0003BU-RL
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:44:33 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfVOf2135153
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Af4RadDwrszYCpIQj9m8xq3nJtPa9NtNLp2qnf2Me1s=; b=eY1oLqNwDeA6qpiC
 maBtE5r9iW/5bOc4df1/+EsF8psaSEfhGZrn692gA0RhGzB7XHkAnjEYq/avgwy2
 ypKDl9roYrlE4pWAVmJkHBTdjacJSueqTW/fZkhg2JTNmHDWHCgHaXmaSg0nptOL
 VAtuxJ0pmyyttvyqgVWlC/d0UbvaSrPsyhAF56nlgmhmOXNCODWWcIk7/PMVbYyD
 EqoHiohKogRcer8YIjKGFTnwBWv90G6GOHUCUghXYI0rl/yR2vfFxaYktPEGbsIe
 ez16+Jbc4M6lYv2vWt9y8zGf7A3T1nuLLJz4giIKcFoZY5O4d3uYXk2g3VHbLj+I
 3WDJYA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0003jmpj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:44:30 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b3b63b9665so1557886c88.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794865469; x=1795470269; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Af4RadDwrszYCpIQj9m8xq3nJtPa9NtNLp2qnf2Me1s=;
 b=ck3Xo/Wgfaz9tsO2aEbV6dX+9upKIvohfNLiXsA8lG8/GA4SW/RzHUn0CTanShArNG
 bCFuHsSAJKdkpfPpqnDNGu3igqf2xobnRTZphS970+6j3UegBLdssb6a/AEZZ5YgEzQ3
 pM+ODWytjwm8C7+pNmAnFfAtqJutl6OfUNXknz/maZKaKxk21lFSAjdRJdW8zAxmG8/S
 H0c1olrlEIyRLCtyQcbMjGibWwZ6KvHcHJJNeMt1Vk4dnN79SBkdW7n2Qi6zHKcXPzR1
 jBC+bhd069wltfRbMcbUbAw3LLmoA0SIQkwoOtsAkajv3lV6ZK35mOcyxdyfjP/nfdQ+
 f/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865469; x=1795470269;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Af4RadDwrszYCpIQj9m8xq3nJtPa9NtNLp2qnf2Me1s=;
 b=ColKtzJ8SiuX/uXN1yHnxYhmBGCjcW/Kt5ET45QpKQvGbz7YVY2VfXa3+YD+Z6RUaV
 oB1F6l81fi0z3jKthHcFZjaGAHaqqbmoVVNHEZ2E3Y3Ius166+I8+rXB9J0mHB9C16bd
 NooJhEpibpyVv7zR5+AkTd5hYFAwcBE98R23X33OfG6riyJRFm3H3TlMq4K1pu1iMLk9
 lZhsSonRG+tkSU1d0LiE4bcY9fVmfKanPa50zBlhff30uNLu+krhzmX2kM42sCx1aBfK
 FrDOu8G7XA/gilh4MDitndMKfv5YKMq66RxhVgHUZHbsSKoyuJ+DiULWb41KgJH6sGQJ
 zBDA==
X-Forwarded-Encrypted: i=1;
 AL+hErFHbH+rdJZCihTghBl2TR8hciFjHzdO/qxfBS96BJfSw66PeHVCHhO10EXFkBUkmujQ5MnCkpdAqn7D@nongnu.org
X-Gm-Message-State: APuU4Z/Ge/A7rM+uJw9SK/1sLATUr4akP7DrFO98UuRFTfmLaV+holGi
 tW/80fhw60M0GogKE5+itU9yEB4Lwrn87iWF8/qId9yCZsq+bbv7Lpt7DjLjOcIoT7xQewGlVJj
 dLedLdVhYEidRpLB78VGajwAmj1jxDW1AAdFURjAtYlXoNLemnxIiIB5zyqq8QVU4fw==
X-Gm-Gg: AYBFou1tsstYeryEVBKEDwiX7FJQTsPqtEZUBPfoz4vw4SExCJKCZJrREeXhGQYzw8T
 RENO1EgrZNznZXQoJY16+6j9Db+K9IV+fzSm1IsT1/1T+Wgy5pq/D0gVZXTRtbhW6luslgfDgnn
 p2Sxtdbw3hWsditLeQwb7pzBXNFWsqS4gp4ZcXa8k2NperDMXToZEktxvZgl9+DlMt549zFgMT8
 xUhyyDmVxJZpJqa6hwXnqMLaHcu3Z827kWbtCjCBnuPZlWRfrgRMMKSELWByRmXotEPfFD7ZzDC
 yVu9F6RSZf15ON9oxCF9kYtZZCCNJeWm6q1u9e5XIessLbueUmFUZsedmWlr1iuTNIJNI9skOrg
 DUn+za/jWYLwfOJTGtT4Gf70wp81/Y96gXkFXvdQFC15NXU66Br0jjd/Ww3auyHhJhJpxiWndrf
 FCqf+8hhCNRB/gHGDwb4DHqwWQUIJjxSyoddpTNfIcnOc=
X-Received: by 2002:a05:701b:2519:b0:1b2:373c:997 with SMTP id
 a92af1059eb24-1b5031128damr10876426c88.25.1794865468948; 
 Mon, 16 Nov 2026 13:44:28 -0800 (PST)
X-Received: by 2002:a05:701b:2519:b0:1b2:373c:997 with SMTP id
 a92af1059eb24-1b5031128damr10876389c88.25.1794865468227; 
 Mon, 16 Nov 2026 13:44:28 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50319d40asm35420612c88.11.2026.11.16.13.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:44:27 -0800 (PST)
Message-ID: <70844d40-3c25-468b-a843-361e13f7af77@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:44:26 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 45/48] qom: drop the 'is_available' callback from TypeInfo
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-46-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-46-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: O_cmEuKN2UD864LEa3xH-HOMebpbjKK4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX0Ffpy7B+io+4
 gN27halrg0C5ovp8PaQFdPovqbuNsMG10S8S1QhBLotSNzCG0sLJy9/9yEYOzuihe/neYjpcM1h
 r0cO1Zcm8L5qvs8QNDeGWp/BvziNblw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX6hynaiccIIp1
 fHX9VTJILIbmRoZfvFKHvCgagoARuDtNWIzof0tSPVDvKFcWbfqXQpCvBtxEoPTaZoAQDF2toSg
 rcwXgejfuWzmRdlnkO0ksGX8JjDqN/UkkSrsPM5vl7U4SFULAQvSHTLsfY/T/s+WPS7VXV3YQ8A
 LaPlURUaYPUVJTbTtpOygRITDItVhmuBmDjY9hZhZxG2a86rietWfgNJ6TFnPZTfDv4I1QiPo0b
 hPUNRqnozHHzxcsDSeDG7ct6kAs8GnoyKsZEu7RcEKnWCj1ttt1ZAoUdd+okwfJFLnJs3OtS4Xo
 j3z44ri8rWz8uv5cSmWKxNTQSZk3B8xsLlNAZyqvFdarYSgGZVe3hBt5cPqeylL3Vq7LIQa5rA9
 usDP+2bqZcHWhsRWT38+SDU8uw3U7dMmHHkAdhDaXGeg2VwQTOceLAmOl1i0OJzqxjZM3wtdkGL
 VcoopMJQsZQZDyoeoQA==
X-Authority-Analysis: v=2.4 cv=Z4N5j3RA c=1 sm=1 tr=0 ts=6afb793e cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=rthXEgwDb10q6xcp4BIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: O_cmEuKN2UD864LEa3xH-HOMebpbjKK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160086
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
> For the purposes of introspection, a binary must always register
> all compiled in types (classes). Any filtering of what is
> permitted with a given selected target should happen at time of
> use/query. As such the 'is_available' callback on TypeInfo is
> an undesirable design pattern and with Machine classes converted
> it can be removed.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/qom/object.h | 3 ---
>  qom/object.c         | 4 ----
>  rust/qom/src/qom.rs  | 1 -
>  3 files changed, 8 deletions(-)
> 

Good!
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

