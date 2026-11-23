Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE2C606A334
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lUOxZIsX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NYdkvHDl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVPHv-0001CQ-1z; Mon, 23 Nov 2026 03:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVPHl-0001Am-I3
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 03:20:25 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVPHj-0007ug-K1
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 03:20:25 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN6Db6Q1490208
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 08:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2w2QT5nrCZJTwEPEFPJ74LxhFykzD1/W6WyZcnnGxU8=; b=lUOxZIsXGW00lDsz
 Yd3PvS7I5GtFVTsLWnoobR0y46TAqIeKrYWeKfGWVu71eO6A8vB4CMNKujP3HQ7C
 /qgmlyNlLY5t76lS0uy+uh5OuRNFaBgsMmkgjWEW02DEeSWAHlCmDZkU2jxzcVVO
 wHOIQLoTAHLwhyqVaFPW4kdV0L+acvigIyN6i8fVZ697CuJZyfvaC4/HSGg1GmqJ
 VnNnvaG07kLswQR+0urIk7zujW+am42IQar3CuxLd9uvFAXoFx8h02TKtD1BxDhH
 OP+hvY7gTYeRxuV8UWWbOess62W/UN4sYKTIzXQZSWJzREpRn+b6AvVSefA8bxAb
 BC843A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k0eds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 08:20:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9495c71055bso608641985a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 00:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795422021; x=1796026821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2w2QT5nrCZJTwEPEFPJ74LxhFykzD1/W6WyZcnnGxU8=;
 b=NYdkvHDloVXPOGWUe6vHlZaxNQXpHY/4ES7mVw47doezsVKWEYGnjfeGoWgYMD4zGT
 hK0J+KPfCHn75lgd7dgjYgq3Pag8RvjUPxyA2bO9hrM7Rsjr7edrcFKxlLamusfYxS8Y
 dO2Um79fwf97wY1S3ntcfUSlMWR7fSyZkzt40KwpK/abNFQ3nPtSP+u/+o5djgt3gJk8
 +H7rjZxINVokwqMnHyFZfeh2wRxJAICjmewZGWJlTNt2/hpYgqOAOKA2WAz0KnIHyIVP
 YHzlnSxBtXqZLu+ADbMpTBzyYuzBAtl+uvdKpf9EhEGg881OHgGKHNj0idg6CoXpGtX5
 tyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795422021; x=1796026821;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2w2QT5nrCZJTwEPEFPJ74LxhFykzD1/W6WyZcnnGxU8=;
 b=0dcFy9gaE9YqbMp4Yoy9MA9Ec02cPMDL+SS1Xlc6qNGFXgtY23MrL+T4dWfDrXm5ot
 4cf4Eip9uuzU0Sydigb6RwxbTWTamUbpot/Su7wN78aPCc/gKWkGywNBK1Lvj+U0vaD/
 bdrWM71xCTnhqtY1YqRKTYnpQT88/L4uTsIPtib9zK4jDHBfBkqCp3HKmjNre4MMLY2z
 LLK8NzmH8yccOcl2V83+TnNkYAfty7qQCu8hKhwqWSsgVUqxUZV0rp8evQg7gmtdJwKn
 trtxaBaK9AWO+RWAIHljT/tKQzvJaZK2VyYFRkfKHuU792elxVf3/pglbXlYSowV2cdU
 lJow==
X-Forwarded-Encrypted: i=1;
 AL+hErEm5AJ8n0sS7BXQANBnCCuRGNRVF/As5jbIF2UE2S++eE2O/TawwWmz18MpWOaZkZk45ThuQ08k1ba5@nongnu.org
X-Gm-Message-State: APuU4Z+d58eQzhESNZjixdeLkgfjJdKwGFtxei6YaFBfIdwcvllR0RnC
 gNRuiirgv0XXYYXtWAKKWfVw79eOwOPmBthEpHLsQ/LRm52xt7guz+jCYMMa+81D8HsTfqF51Uh
 XVjRozWpKQR943NxQmE7PnNGK2QX3F/MDrPTllBnS0bb2alIYGe0vkNXcvg==
X-Gm-Gg: AZFdTZca1sxS4ov4GTjWT2xv4bGjK2COyQTD6/OexleZD+sDxtgl5md1FJqMEZ9OHTB
 eXbuqC8MTpNS0CaWATNH49g7LFZscwEACZIG4A11C3tACsETV9JNZ3d7p6IPIGT/SQofiFycO1q
 qeQfmyQWPpyOeF/iLrBbiYwKXzK/E334bFv4aVwpiEI+bQvliav89Q7+9fmvWrnZ4RgmsiUwguI
 sRvEUb+0pqAwi6e8ts3CJCtwdgp6TBKctr3uAXEpY1OeipnKBDEIEvzPndir75xnvbpRl2s4ajm
 F6Q43MAgCrjPm+OvYgpGBDs2e/Bwc72o5utPxUPMK96P6i3m3rjte1qEme0SxX56ulRBCdciUzE
 Z/vLrws5u8bLtGO7+/y1hH1zHuhT70Xcco1r9bzPPZjDu6UnUDxlohJAH7oXQGvWSfWlS0IYNJ7
 MY/Xir/B8=
X-Received: by 2002:a05:620a:838a:b0:93f:3120:6c6d with SMTP id
 af79cd13be357-949ba9fe6fbmr1754127285a.35.1795422020995; 
 Mon, 23 Nov 2026 00:20:20 -0800 (PST)
X-Received: by 2002:a05:620a:838a:b0:93f:3120:6c6d with SMTP id
 af79cd13be357-949ba9fe6fbmr1754125285a.35.1795422020625; 
 Mon, 23 Nov 2026 00:20:20 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm476087135e9.11.2026.11.23.00.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 00:20:19 -0800 (PST)
Message-ID: <b9916d64-462f-4029-aa4a-ada576e79c43@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 09:20:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] iotests: use gsed instead of sed
Content-Language: en-US
To: Roman Bogorodskiy <bogorodskiy@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
 <20261122164905.59680-2-bogorodskiy@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261122164905.59680-2-bogorodskiy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMiBTYWx0ZWRfX/2p77mrG/Ctz
 jRtT2Jc2QSHGcxNyTPgH4fBKb1BCoLmH0zB7hR7v/IAZgROUuPOHI/pwqUv6pL6kvkIoAzrHGKP
 2l3Md5K2AUK3MD+bEWVLv5YKCGp+x6Q=
X-Proofpoint-GUID: vJqt-7dTBGdwuHVpMC8qde-3Xm5DQFKT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMiBTYWx0ZWRfX8eIPp/E+TFZH
 hNFjUp1mb2TZxx6m57KiJv1nDzAJxeTW/mBuB4almX9w4BfaRViDtKp7oeYOX7gZz0iv40wWGxL
 AQlyvZUzROhRGEwTV41hnsDALXca+wsD1qpNDFjXUQVYqU0F8ounBZNDI+orNkUrWelgP8hYRZa
 i2V6HO9rBhKixP70LgxGht+BBsl8dRZaBizMdgCpBQZh0+gpyx+MujljGiFCU/R90F8Hyz4F0w0
 7pPv6E0OOHWv8Utd2beVxxp8OPWZ4KV+iSwMco57CQYNn5J6CXw6RJoicLsEgd5XSdq/+3HYKze
 8TUpzgPE4gQUK/N7Ui8L6FaqSObKMlfqxnF79jxNzwkG3Boi6RrOvjz1R60tuJI9nwx21OeupEj
 iGcYBL/xTzLPSDsTu3DcTQXwlW3UlyXldL/izrUBB5ItTqNmohOCloKG8CZsUlw8k/PiUNHhMxh
 jq+DJ4jm/ld2EzNPZkA==
X-Proofpoint-ORIG-GUID: vJqt-7dTBGdwuHVpMC8qde-3Xm5DQFKT
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b03f745 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=ErDFWq6s_ESgu97rX08A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230032
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

On 22/11/26 17:48, Roman Bogorodskiy wrote:
> Some iotests fail on FreeBSD because the tests call sed
> directly, and BSD sed is not always compatible with GNU sed.
> As common.rc already provides the gsed() wrapper, use it
> instead.
> 
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> ---
>   tests/qemu-iotests/115           |  2 +-
>   tests/qemu-iotests/common.filter | 26 +++++++++++++-------------
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
> index 5c8a12f85a..e3ff91de7a 100755
> --- a/tests/qemu-iotests/115
> +++ b/tests/qemu-iotests/115
> @@ -78,7 +78,7 @@ _make_test_img -o "refcount_bits=64,cluster_size=512,preallocation=metadata" 256
>   # qemu-img check for that purpose, too.
>   
>   $QEMU_IMG check "$TEST_IMG" | \
> -    sed -e 's/^.* = \([0-9]\+\.[0-9]\+% allocated\).*\(clusters\)$/\1 \2/' \
> +    gsed -e 's/^.* = \([0-9]\+\.[0-9]\+% allocated\).*\(clusters\)$/\1 \2/' \
>           -e '/^Image end offset/d'

See for history:
https://lore.kernel.org/qemu-devel/20190307145839.13128-5-philmd@redhat.com/
https://lore.kernel.org/qemu-devel/20220216125454.465041-1-thuth@redhat.com/

