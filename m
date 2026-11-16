Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA68606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lioPDxxQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VEDWRns0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Un-0004bs-4F; Mon, 16 Nov 2026 16:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Um-0004a5-1g
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:44:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Uk-00039u-8o
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:44:11 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfoxP4147231
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p4cKbQBPSnBe6uqSSJYgr1TqvtjDj33py/lFDJM8xVI=; b=lioPDxxQwXUdvmLU
 fn6mF5h2XZg8QEAyiz850MC7mTzXwbsdzn79iLrmdKzsz+Jv5x2V+9o2hN3WimF6
 c9j785MSsK/IZRTWQhz0fXcogefNS0ieazO8t18yelBPPopHKhU3cTlxVgtuFrnH
 66hhUDRHWswKl3sXIbTkBXMl2RSYRQl191DORtHvfmrNNG/5t4U0qYV0oOwXg8TV
 VXpz+XiSOlz2dOsLanFSuKnrUA5YsihCHC8o/NYfGckcinvFiHDdsczWr6Vp3WJU
 7iNSeHUP5jOa82lSMU3vzdVB/NTULqIykmbCDzTtmG13y8cLsNX16KhzGaw+YDEr
 RHcQlQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f826yb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:44:04 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b25d977b91so373189c88.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794865444; x=1795470244; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p4cKbQBPSnBe6uqSSJYgr1TqvtjDj33py/lFDJM8xVI=;
 b=VEDWRns0F218nwAw8mz74BU87apUfGBllI4kQH9SYZMBSH0RZB2WPree+Jy0VKgset
 7pDXmxTqz0boEw6HGerVzN/+LwF/PBIXxqcSEdYmVtpaqAqtvYPQC5VjUzGp7wUmkuJ/
 z2OhYXkUVQRZ42xWaAtnimppvGwLod4sCzZWzQIVUw9N3UJRIVJASYR8GN6DPNO1Bb/w
 7bMF/tQ6U+QMKz540R0LIsW3jplaWKk73C6JMnQtejbjLvJ1X7+ylxCwxcUvx2mD0lrs
 GnJaT69MKYLXyjNkOYTLoANAFHL65arduaLAHMLzTtEYP3/Zdaqnm0+QEXEIuM7t0jtN
 j9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865444; x=1795470244;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p4cKbQBPSnBe6uqSSJYgr1TqvtjDj33py/lFDJM8xVI=;
 b=xHTt8iBYNX9SxAEgbeFbUKPwPt6utRIvtIPyNhji21R7vbQCgHQPoWIzutwRH8fnVb
 fdY2gLnnWJ1plgrB7KNBbbmh3HG53tE37UuNHTOpYmZMWX5FtJbx4ww82aClQJvOVosb
 M+PRgWMrF03o5ZdHDimjtTG+MzQzbjjWqR3ToWDcUxGe6T950QyDFL26FucSevwB5DaT
 7/dXo8264LkBwOx1ALFx5IgbJQwLwOYfK4ByKdY+iof+gBy2Ilqm5DXjF51YsrxMZtRN
 UaQ6PEt1riWchMxjb+dXhc7HMpTUqkYP+0bAs5ZOBmd1xsGem527Z9WDadNMxmtPbfqt
 r1cg==
X-Forwarded-Encrypted: i=1;
 AL+hErGRhk47aSwC9Ew67J+f61JMPHdKjo0iUjKTm7XTarJvCLA2Wv39vE5J4cpfW/7r1cqwt/fSuUErxRKN@nongnu.org
X-Gm-Message-State: APuU4Z/a2jwEf2K84VxPymGxGII8Z1jXYOETUaOG+eItXkXsBuAmqY3f
 Dm4AUSxIC9TvxhFA02fvhAjPCwpTN7OaPJFUmI6+4cw0Qp4zti1g396NJ/ZcFZu6UE3pgjaW8cC
 Dkwudu5rkwSQBqm35/5kYjn4XPSsrAt57fIHgOipH861nrPxMtevZ0tOJrQ==
X-Gm-Gg: AYBFou2SK5d30dTHscAhlDtGfbzZi3mWwSm17WKdK08p7ZMfK2LdKSjigcAXs29DjRh
 g23v1ptOH7XI8wzr27+V2YPa8dzJ9Yu6DkHK0fGF8rELyIeKRMD8NtEoNlX1zuu6a/xoZQhArae
 MFlj2gnqWIKxiGeDqFvbxaI4I6mWbxX5I73vrK3K+gWT61BwwYEDLXQCN4My8YxbMUmvcUc20+O
 m3j+XRpg+9NnzC/c9I3IDCPM0wuEEw//caFfNwLEWzQTH5RhKyzoKCQ0vPiKR7EigShx8xvaIOA
 5h16bwev7ZWIoXg8HgiqdyVrbj+9ZQysHieMFRDEkDRvN62n6Uv+IPAAcovZZXKCU+qd1qo8HWt
 kE7yOW4swnN3uHgQ7G4K3iAOyx0ODD6pcPnL4pdt88oA4OK4saU2Q23XBaMCxBMvZCf66ZvpXXS
 fZlW4jw9jWPF1HbWXoYQSrLla2CQnr+pBshYnnRpadSMw=
X-Received: by 2002:a05:7022:ed02:b0:1a3:9936:d11e with SMTP id
 a92af1059eb24-1b50313d85emr10398390c88.41.1794865443717; 
 Mon, 16 Nov 2026 13:44:03 -0800 (PST)
X-Received: by 2002:a05:7022:ed02:b0:1a3:9936:d11e with SMTP id
 a92af1059eb24-1b50313d85emr10398370c88.41.1794865443170; 
 Mon, 16 Nov 2026 13:44:03 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b524049e0asm15520160c88.4.2026.11.16.13.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:44:02 -0800 (PST)
Message-ID: <d7b5523c-b8f0-4076-85e1-2089b2ba5cd8@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:44:01 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 42/48] Revert "multi-target: restrict whpx-accel-*-cpu to
 matching target"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-43-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-43-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX/dHEoKceO9wZ
 FOB0t6V88oZ5FffEG9EfKfG7eU2BTY0LHmAsjVHdTkzKQCNAAQs4QhtPp7sOq63KUff5QqM+peO
 DyH54pfSvb4R6kEFkI3Wkdy+KOS0rbnQCCqC1EuYhi2dXb1FbtSJthV0V/nswgoV/XyBnoQBW6L
 v6+YetZu3oskTdfnqFTJcaJte+4AM110bktbuWgQVffiVGXcZQ75+xZWpxbXPEtbfp36Wie0Qe9
 yHxDf2V2ghvnd8JwbV1+sBjCUZ1VyOQ+oGKdWHcLNUr7d/4DGcxu5YkY98bohQ1rgzseNYMwPgv
 g4xa5AKzF9KuE3R54M8iw1k4ucauCELX2JmiL+GZOPeX+FfZD7HrYBSf2C5DLtwKVx0KViXj7va
 Ny0rnLNv3SMwWX4W7hiM8tiZuILy7Q==
X-Proofpoint-GUID: uDPVAFkNwt8O8NBkhOtPgRdwjfEB1Ie4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX/4Q5atGV3UFv
 LbY+Af27Ej1iStIJaK1FmNyp6h98YttDWBLKX1QrLp4swjyX4YNFmNL5wOY1K0j/Ach7ctHvIsj
 4YWoLUhBkojQ2+eyeJcCNBldfok4w5A=
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb7924 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=EnuhjQ2chKAxP1XGzAcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: uDPVAFkNwt8O8NBkhOtPgRdwjfEB1Ie4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611160086
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
> This reverts commit 1b879fe489f8894c5b07438f0b10706db916ca4f.
> 
> The conditional registration is no longer required since the
> base class is now using a target independent name.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  accel/whpx/whpx-common.c | 8 --------
>  1 file changed, 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

