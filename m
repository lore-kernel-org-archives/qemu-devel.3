Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E054606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RMtZ9HSZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aGKMZ8xW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHqH-0004Ze-Va; Mon, 09 Nov 2026 00:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHqF-0004ZI-65
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:22:51 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHqD-0005W0-Fa
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:22:50 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93KVkB1650104
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 05:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uqyNMTwBT95a01HdgBvE/mRq1ErZ0Ai1pR6mrT+K9CI=; b=RMtZ9HSZMpQcZNLD
 qNEcs94X0+NSv7dlphjXSzZYcSsL2uxV0H1gswM59cpm/vrBjlR7pdStBVhEB+Hj
 c5zxofE8M+kTEJqzSrTzxglevWq3fqGUvVTjXlRfMTFgvIA6m245yyMzn82lM1gU
 kUIVN7cPoJ24T6Gh0Fy7HkSLrughKYqaQDf4KGlzGtYLPCrkG8IFJoONrFIhP0MX
 7FiDvSSorKFmaIjXe7joxJdVdIsC/t2UNqTlaG/nGxurXTnxNj0a2CNIfHhzOhYz
 zOZh83Zuxz7tR/XbMlIKExXpEXIaDCAtJDaacaFl5WuKC1FP/k2jA+5UIl0q9nWn
 9aKu8A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw5k4mc9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:22:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36f1e7d9d4dso1218991eec.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 21:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794201766; x=1794806566; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uqyNMTwBT95a01HdgBvE/mRq1ErZ0Ai1pR6mrT+K9CI=;
 b=aGKMZ8xWBVSYoxOSz4kXysTXb2RWNL2FtItKNjTPlBHnX543PsvTN57Kv1puEmXXYj
 sYI+RukyYPhQPEGf+0HE3UG14u2L1jToVsJoqYvoYMxlQ7m7x1eknHkOkXJilsrz+ZQf
 VI+AlUaozxcpjqIj9+l2B/knjXSVKuOnPQCJHErepFQPeqjYkqtaJrPy8tj3tsmvTSoS
 2R3q7nDl1907tJS3B9jD2x2sc4ZbKptfxl5qpm3bxA1Ak1me8qGXOP30mFYXToYEmjml
 opcnHX6eNZB+ZV8RcJCyAhI3zsLe539xtpWq9fKd8pq30Ni+gy60/DczfmAAQTWWcseK
 Mabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794201766; x=1794806566;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uqyNMTwBT95a01HdgBvE/mRq1ErZ0Ai1pR6mrT+K9CI=;
 b=1cwn6t6RbbgwWupg9H07c+R47v7Dnr5A0B4LzhrI7Yt3nlbo9Rx1iKw9SKO05c0ySD
 2qmEmO53IA6yYEE4c32Ins1zLuOyYBtBzkwzQt/dhOwMIfx1yoj/AFi5VrN4+dHeE3kB
 L1ImO6PnLsBC0jXJE+KZyFjNHEEi/qTxgd+P4fRLCnf0IgANgFObDXLEW9yXy2YgI9SR
 6rHVreGBBCdgzif8sULBQ2gGJd1RKmr7fSFs9DBE2PrPsag+7Iqub9ZcStqL9D3JF8Ly
 Qf9P+NOj+eDvzmVrG/XsXweL0GA9KZy8ZJNdtp2UGWiZEMXkjeBkYZpo47j0swUvfego
 nFCQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGEjLKRxA5ysgGn0r98oyBY3CbJq3US0F9x3e/5Gf2oeBZTfVEk2wi/j9YMW2g78Wb1ER1TBBlthPeW@nongnu.org
X-Gm-Message-State: APuU4Z/EYndegVA3YBOV7Y0nPaL57Ku09b35e/RCyr5TgRpQ55H/DnW3
 +t4D7Vf3n3zftnAFM/eIfgTQNDKnOCN9pUMmB/CJbyBLM6iw00Kaf2H7Oz5kNKbvf59uZCAWcG7
 NasC6F3FFcEDu6xriqJiiQt3iSOyaxRY4sitvPVdyTIRf3ufnpQzMxLXKeg==
X-Gm-Gg: AYBFou0hFqcsMBf1xsZlNPK+ErBcixlgtge3N2h75O0KIL0CvkdNbUfbbtuc+opTO6+
 LBb3jF69CZm/f6bWM4J6yZcIy6byE/w+9eULxVfDe+EV12le/37CV4ltXlXtyMAfKq8ig4ISKZe
 knshYBnYZ1k91ayLcikRQaGXCDNcRAzclTpvFWF3wCg3saecYJDCdocYVbaxLWcF21iMsq33OAs
 QXriHug3nLrKJ+y49n2cm7Ha2ovSS8FP4fn83jo9oUrgN+B/H4OAKE8/EuQay16FjqIZ1MLc2Fl
 jqsUq9ALsHZWopjl0byWz718R2dX1M/7BbJ7PHXRgc0pqmgzAQQtbM5wGqytLcV/srO4UCGyBjA
 1x21izWrplm92mvuuOiH33EHARiYiXRH1qOYVKYXCcR+S1ZM/q0dFnL2Y9aWx/MvYJnBpxQrK7g
 RXOogSUxrWGp8Q3ArCQKegTNcQbapRjoCo/fSd6gtl1Q==
X-Received: by 2002:a05:7300:ce86:b0:35e:f1a5:9ba6 with SMTP id
 5a478bee46e88-37252b4c091mr5643966eec.5.1794201766311; 
 Sun, 08 Nov 2026 21:22:46 -0800 (PST)
X-Received: by 2002:a05:7300:ce86:b0:35e:f1a5:9ba6 with SMTP id
 5a478bee46e88-37252b4c091mr5643937eec.5.1794201765708; 
 Sun, 08 Nov 2026 21:22:45 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3726561851esm10437306eec.4.2026.11.08.21.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 21:22:45 -0800 (PST)
Message-ID: <40b9f7a8-e1a3-4ecc-acb0-3b1afe19895a@oss.qualcomm.com>
Date: Sun, 8 Nov 2026 21:22:44 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/hexagon/virt: fix firmware boot
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
References: <20261109050327.1475448-1-brian.cain@oss.qualcomm.com>
 <20261109050327.1475448-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261109050327.1475448-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfX6xzY4RST5hs3
 5xQAiH1plrj420o336uHOmTCmN6cl5JrSAjKkFMm+XnVGXAeqI/cEPUjET/ybisfxaqS2qrwTop
 B9WdOAk18HxcbHmqNXKz4txLmS4a8ei9S9WQt2/IO0O0dvzkNMPt8VGpuRDJBZ09Wa1nzUZMAIt
 l9xS6vZg9LT0iH39f0Kp3EWOwuR/Y5IxWwPQtpMxN/npIkHLnoQUVcwMNVElvOQOvmVAyReu7KC
 aKh0WSAnD/1lhrzaBhN/42pVxq5/qQpxMFheRtmyZ5r1qjenEoy3Yx4l38a3QIRBAUAI2VFiFgR
 h63S7bNoCx5WOBWKsSCGW+JC1F05FE4GZ7Oo8+Vdl7zKUFkaAIp3hagOx+9vCvxMiYCKTMsYisy
 t8Qh0lOrHJIflmnnEByjiMQ9osMwfMzot5+3W2d9/B1JJVN8grD4gwhBCxE7e4w0LAGVMFTqlF1
 GgmNEP6SJ2G15mfR4fw==
X-Proofpoint-ORIG-GUID: B0PTZSEwjTNXOO6iq7IfayyF8ign9nja
X-Proofpoint-GUID: B0PTZSEwjTNXOO6iq7IfayyF8ign9nja
X-Authority-Analysis: v=2.4 cv=G/aJgNk5 c=1 sm=1 tr=0 ts=6af158a7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=YAk6_wHmOggZnrnG6V8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfX9/1zxjaFNYu6
 4H/HWaKg80H0lIFOpNFjhjbQDkcOYBzyrIjZ9wsXc3kNJwux8aQLMQvHmW9kY5mRRy+ni3CFBkd
 WIH5TAOoEjc8CJeRF2jE1WoobH6QLEk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090020
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 11/8/2026 9:03 PM, Brian Cain wrote:
> -bios on virt only loaded a raw image of at most 64 KiB at address zero.
> This is useless for a typical case like the h2 hypervisor, usually ~hundreds
> of kb.
> 
> Boot a kernel given with -kernel through the firmware given with -bios the
> way the DSP subsystem machines do: relocate the kernel into the window at
> 0xa0000000, place the device tree and initrd after it, and enter the
> firmware through a boot stub that passes the device tree in r1:r0.
> 
> Fixes: 88a8bc7f43ff ("hw/hexagon: Define hexagon "virt" machine")
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/virt.c              | 79 +++++++++++++++++++++++++++-------
>  tests/qtest/boot-serial-test.c |  5 ++-
>  2 files changed, 67 insertions(+), 17 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

