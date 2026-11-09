Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD833606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hoHm8DMz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nkaan6ks
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQNAw-0000dq-Ef; Mon, 09 Nov 2026 06:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQNAp-0000dX-HC
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:04:27 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQNAn-0005Ae-BL
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:04:26 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A99uoRc2503007
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 11:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gCbQP7TPeyfp3Zr9xf+0Q9KG5rQY+MQM4ErrgcfxZG8=; b=hoHm8DMz/FOvLMwx
 AWpbed/jhISPp5l94olZ4Lr5WgpG6hVXQvzfnsxzgr2LUE3GMW5L8QFrJaxQftl2
 qpcOX8gdYQ24yIEZ/ywD9FMK1de09PsacHVqOY2x5cH1ejMdOHTU1d/9x7md+UpC
 ogtM/goXyXoB6r6TP1BorQWxllKd1BHw2qFjxcmy/gCg5pfEjcuKkVir/caSodEL
 zEDRjPW0sEHizxzDxycTo8Q6sojhil32A508c86YzFDUzjQRyV6eiVjvXKrEHJg0
 AOdGPjEuVvn6gd0L9DFkp4dbO3ycVjtFjDClDhNK/G6m9pEtsBXwCanm3Xsxgc6n
 VwMvsA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hubt8r9yk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:04:22 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99b715e4f44so354241241.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 03:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794222262; x=1794827062; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gCbQP7TPeyfp3Zr9xf+0Q9KG5rQY+MQM4ErrgcfxZG8=;
 b=Nkaan6ksrc/0nTWEJK0tgLuySao7/XuMvDywUV1q3ev105L0HkGB6dOdIxoCtGS/jn
 u0h7onsIYQhCzAQwIi3YguaVy2opOOtRTsH5D9aHao1uDM7PlvNcpnoEMWujLHQclaFu
 WANSlt8xQdRMuQ3o5lcyRREJOEkt4RE/R0+K6pCZ+vEsiILXcWEvuHQm9nJiKjrnddP2
 vr6+ojSxwdMoPs1CFAcImeSEs0TuxKYkLKQgSfrdnAvKhNZ1l3b0wQEtDAbgFhVJQJKR
 T9t+xm2e7h80oRPSGo5Rn25hJAduR/jMY0qZ7AqE4bLSjzLshpEFhVPsISMABAuKF7z3
 rUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794222262; x=1794827062;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gCbQP7TPeyfp3Zr9xf+0Q9KG5rQY+MQM4ErrgcfxZG8=;
 b=WTDE8ZSfUbrdwtwesnkVzPMv84YAqTxBWZ9aw5/dT9N07bVvabg1sCeFI/wmb/UlfA
 3dVPBG96lXHu/ZhoTVQz2EJnS1xZLKP3gVy+mUxzIqBXUch0WZ+NtGBGUK0BoAUCuMUY
 7QpM+wpDt5WhQZkmmW7uS6ACpZAKexlMZDOub5n9ZmgYxs3J//JSOpE92SrA07WENw2i
 Ga5imjrP+/tGT5PkqNeSoAFswnOI8iCSvnCEASJjVxhaM+Ht4somO+w3I/iIkUiyL+Oa
 WyFvoPcjbb2DdH8Az2dCvWDNhxjk3PLMP0c39B5C+eyNx+ujSdGbsuS4UHN6jfQDvKGV
 dfrw==
X-Forwarded-Encrypted: i=1;
 AL+hErHomznSVJaCjUB0ttsX6t+UgDm4D53zHycs/I2ayNG0DJksvPPf8JPhoWieALp4te2+JX9DkVIemfJv@nongnu.org
X-Gm-Message-State: APuU4Z+v41z7UuQ7jqABH8IPhvWs0575tnP+xjpNnYz4p0WDcUhSSTJt
 eeHt0/GgHdHmr3cxNpRe2NKrY66mV52rc0HquanKTlbMjcOEdA2tVJpGw+GCaFd0rbml/1EYUF/
 Krg+4VRVKyXMaMc8AjUQ88oanjcOoGzvrvVlSKi/nDJWin77eBb0o/Sr6IV5gM+Rgow==
X-Gm-Gg: AYBFou0rIw7IqdKMbv7Tg2rwB/+PNMveSUZBruQ7BFEApwHrZRCLrDCQBDxqsG/JLHl
 QB+BsTJ4M0RcgLLDmn3BwSOCe1gC7lQL7z+167Z4OuyFURPxgULjgzA7FqQe8vQnHwU3oqe54qm
 GlQMTZtrxPsWVijsl33iIiYFtIJPyLULwwQFBSsyDJdtxAx/AdixkEutkjR5KKz803RO9k7XL4x
 NoJWte23V+fqj4PHvdj4gw1X7JyduC0A7WzqNHD+QJw5NKvZRAua/rM/8a2uizFXZpsAIkG3uCs
 0knhjEtJKwo7+h5Vm3ZKfHpTGedVTaN6JFrciHE64llpn46nxeXyeAhuAbtendnLNYQ30gC/h30
 qhDkZnThSJyhHoaS0a30mDcMA2hC1/9sjINf95srH6xkgMl1zX75//kyumEezO0IJNHn/kfaNnb
 40/JptLw==
X-Received: by 2002:a67:e104:0:b0:7cc:2cd0:e74f with SMTP id
 ada2fe7eead31-7d2db1bcf74mr687087137.30.1794222261606; 
 Mon, 09 Nov 2026 03:04:21 -0800 (PST)
X-Received: by 2002:a67:e104:0:b0:7cc:2cd0:e74f with SMTP id
 ada2fe7eead31-7d2db1bcf74mr687082137.30.1794222261084; 
 Mon, 09 Nov 2026 03:04:21 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbd082dsm132973755e9.1.2026.11.09.03.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 03:04:20 -0800 (PST)
Message-ID: <581beb95-95d1-4289-950c-07e047883089@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 12:04:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/lcitool: add mips32r6el toolchain to refresh
 script
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20261106171836.2020151-1-berrange@redhat.com>
 <20261106171836.2020151-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261106171836.2020151-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MyBTYWx0ZWRfXzeGYHLjwgidh
 kSPoZAcgpAaZcbLhSal0cO5Yv3K4zEpnBq9TpgGSbkK+wBNw6Vmwz3CiOdIbHfwzonXjT5FmsRu
 sjDYkUzVUQQ1tJxvaXH463O7hI0FcThQHkwJveKvLBZphCLWZ/RFt4eVoj0juBqcswl76+x6AN3
 pdpC6YtRcsDy0r8rdXf/4CW/0dAWgoRKszxGqQ8xgo9tVplED3X0zVUtt9P2u4jwJ5rSaGg+egk
 E+lU5Ask1yDpyuxufZQakgKdYJlNEmDx9lFPojEH7FqOHD33Vsmge59fPBxOMj+87QRcfOIXSoU
 Trtt8OdiLlV8cEZPEc7pZquSP5l5V2WcVbj6J4a4jrx8sgLepcakBk0WAZS+5NZznqZDZUKN3DE
 vJv0IY1Kt7TBM4eLT2+9qBKbiJgtmxnnUJVNZyB5qC5PgjCcLsGAz1dLaGwsNDlgSwnyvufHF1i
 uHt+/gfc+0F+amTavyQ==
X-Proofpoint-GUID: sY9dFcdPyUgrjno9K13MF5fNmPaISOAV
X-Proofpoint-ORIG-GUID: sY9dFcdPyUgrjno9K13MF5fNmPaISOAV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MyBTYWx0ZWRfX5pgodBIK524b
 49cYavygWAWC8zQoAEPcO3GpQniIYy/ySU7rMfumRxbOg0DsVEAonYUpW5QnNSvPAXkoQ+Bs1jS
 eJ1r8Dn+Fie+uQPw3AQnS2expKKqYfo=
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6af1a8b6 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=nsVnH0MT0iiyI1EBBOoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090043
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

On 6/11/26 18:18, Daniel P. BerrangÃ© wrote:
> The debian-all-test-cross.docker file is auto-generated so
> the extra toolchains need to be listed in the prologue
> in the refresh script.
> 
> Fixes: ace0b0b3d104 ("tests/docker: Add the mips32r6el toolchain on Debian cross container")
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/lcitool/refresh | 2 ++
>   1 file changed, 2 insertions(+)

Oops thanks.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


