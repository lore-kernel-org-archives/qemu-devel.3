Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D4606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UMWcqUhX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GN7fCn1m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBOf-0007hW-KE; Thu, 19 Nov 2026 18:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUBOd-0007hJ-Pf
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:18:27 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUBOc-0000Mt-7K
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:18:27 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLecos3538378
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xAFqOi3x+SLUX/JUl58ne52P6wn7Q64+s0sXYSShudY=; b=UMWcqUhXALsg+h2R
 FOlLpQQGJiejFQ+uONnre5MFUfjLvjUIe4XVTjrMSvdWj80b0BG2843tyK4VoHdr
 m6CerF1o/56UP6mk2aajeTgnM/vxSxDkL/gn2ToPzu0sxkhTELqyV5tXSNLRK9uu
 2Vd2ZxY8OURoKP/5xOaV0IirZeVs/u6fkUFOK1M0e+6rO5ua+59rAd0SXuwfFZvA
 sPBelIwB/nBe6W7JcQhIH6aCgHg3vOKscWk0HZ9FsteiIGFtql8PQgTlXoQkD/XO
 IOb3bEvaU137iL93Hwkd5oplR+yf1b2emg3TDSbxMd8ahf76NOpBoTwprLyzH5GF
 zY+gow==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fygukk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:18:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-383ec96a7deso273346eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795130303; x=1795735103; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xAFqOi3x+SLUX/JUl58ne52P6wn7Q64+s0sXYSShudY=;
 b=GN7fCn1mIo8Vb+u4TLZVadE56rkXUOvJhmTCVzekkDb4JWX66guxBZ+AsCAuqa9NAd
 /dqvkt7f7zAMu1lAtb0OamBg/FxVkHN1sstB9qE5Hyc3R4JLTdEKdVL+6vPqo0unOCrS
 NlMsWemYaDbLVwbjIIotvusxL2d3Nz/lA7z7AshesaLpgXvLqHyTfux92l+xMNfWqQGX
 9NU2TdBj7MmMWqmS0EQ0jfdaooU5zBSIb0MocIizcwZofvn3ATKeQgEkm5xH0lprVhqf
 gRj0GSe8VaZpDoC0QeBwD0BC6yVFu6WGDzjkx1aXzSvutCJZIQGxWT6rGuR+rOhnNllx
 126w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795130303; x=1795735103;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xAFqOi3x+SLUX/JUl58ne52P6wn7Q64+s0sXYSShudY=;
 b=q60YOsqzYbc5YWrxXnGf9gkf2bI6Ty442bD6UbrhXWnyqjdQT9lflkEJUPgehVct89
 hIM/drm2/cSSxUE2noaIhDCPeGk5Nmu5cu+/kKDV3malN7rTNACBSHeAkRUVKgt19zLZ
 4cxogMmgb40bwcibEgLmXTBlAIYDpv47Y7V4R/jkNnvR1Wy2YKd5qUh4dYWXqaHhjOro
 8Uy6hvqO4Q/ifd2VYCBaT84Zk7k/ypbz8rtG2aGQfbEkdS+C/YVOZ6kjBCESU5SZFW24
 kzXAFs9LHSymTu+9RWH+sQBrYymP9bEsUKNkHPanRImESASXPrw+vEfMGX9o5YGRYeu6
 aQ4A==
X-Forwarded-Encrypted: i=1;
 AL+hErH99OyRG/Ttp2MT2vvbz0pXzyUjvWtlWot2NvoZYDg38PPHCo+TiU9ZWZ3M0TEhDC6XGxu9nP2XPgS3@nongnu.org
X-Gm-Message-State: APuU4Z+K/pPbOeb35Qg+mMIaGGzakVzRLvwdHaG1a6+pqrnqRrMgyul0
 xSC+JYy9b2x5Lphxlow8mNTJdiAAXXEjuwzt1qrvT1Hvr3NN7uPiZ7fBjLwJLii9a7Wy38xzO7y
 u69sm4lzM269WsduCodnbwAwJf9Ls1pUwh0nlb/pHxpECb14Sbb9uVg9Gcw==
X-Gm-Gg: AZFdTZdolmUKwUKG087ypIbJe32uMumkC/McwjBUTdo215zoJ+erWepLh2kM7buvBiZ
 n5yXyWYUZa3tLi0qdeWtHxR9k95YhczL67+iQy8t5pupVBrAfpPNIxWeMddk8PLEYQP/ffXpTE8
 Kg/rh+8z7+TvZ+kq1qhmSrRiFQnaxlEKwvC/1GANfDDt/O089+FgZVXq2wIqb6a4aEETxmDblgG
 NG5Mlu6qAAmXtNQ0o96WvNWBubfNtsRQA6lnmzV1XeMY+IyuNHxrgOZZ9tj/KUjMTHPyZkjNOCy
 Lx6xon9XqTry5GK3S//6W1TbcYe0ZJ9xm/M2lzy3XyBocmVudfvCLEzaBpOn1EazLHHP0ML/Ged
 JgdkVq4LZ404+i5qTvOKNcEiBjYpUiof23LL9Lk9QrsixaBbIFCW+Skx3EoJXs2tK9RtlIIfbub
 xNvtwC7Bwwpwwo/CSX0KaVc9JKNlQuiP0CrULq
X-Received: by 2002:a05:7301:7e07:b0:36f:9d8:4a33 with SMTP id
 5a478bee46e88-38570e21c39mr870623eec.31.1795130302810; 
 Thu, 19 Nov 2026 15:18:22 -0800 (PST)
X-Received: by 2002:a05:7301:7e07:b0:36f:9d8:4a33 with SMTP id
 5a478bee46e88-38570e21c39mr870607eec.31.1795130302281; 
 Thu, 19 Nov 2026 15:18:22 -0800 (PST)
Received: from [10.248.104.162] (160.sub-174-226-161.myvzw.com.
 [174.226.161.160]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm2075053eec.26.2026.11.19.15.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 15:18:21 -0800 (PST)
Message-ID: <f7fe49f3-7467-4c98-b41b-b23431a9aa40@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 17:18:18 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] tests/functional/hexagon: add packet regression
 tests
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
 <20261119215853.987158-16-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261119215853.987158-16-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MyBTYWx0ZWRfX3rfzQ1HrObmX
 FhBni0Fff+mRpF6HxGcUv5XvX56xEB74DjNgLPPS2uU2KTFr5V3f6Ekp9Q7uItUidVHxeazEmn2
 AclBsZVEfCSf/5lS5wKKU5azvES1n6k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MyBTYWx0ZWRfX4Vdk8dDNAe/r
 hayq8kbnvl58tlbVfD22yqWV1jYBmrjLGwleWKjXOutE17gGviY37oBH97lQ77r7uhB2WDo1wmo
 L3fbz6Et22RyWpYnTXGGaDTuu9EXFWdKysXl/8WEIZfFN175aAreH/1UHz6O4CicnPZ2rHLThFb
 1swwE9LdDhtC0v01rMmX0uvWNsqjNKsR7PkxLONEy2eBHSYbUeq97BxQObXFWSojsNGl6JSEdLT
 jgl/oBpu3OAUXfgake2xxmUbC8Zjep/a/Mm6UNUjbxs7VHkyM1PfFbnOt8upG7jwZg6EEKajn3P
 rNXp9+rTgppUGgc9eSI0/7+0Y99sAQW0fA36ya1gO98gc2tl5EIdwpU5M0QPrkBRGL/+WYQcaeG
 iKUhdQd+8WUOYzPKez0GdTZNfrItPDGtJknIkl3SaPIKOS5fvZ5xKRYMtyGWn6s2L8fvF86I92H
 PWFNoxGtUQ5VKFCuYZg==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6aff83c0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=GMQ7njlnOdzlMr1UnwV+Pw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=AgMLBXcmmoWRJ84jR0cA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: NTzpTxRRt5J0AF7pTEu8rV8wysCjud3s
X-Proofpoint-GUID: NTzpTxRRt5J0AF7pTEu8rV8wysCjud3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 11/19/2026 3:58 PM, Marco Liebel wrote:
> Run the standalone packet binary from qemu-hexagon-testing v0.3.5 and
> check all 11 system case results and the final summary. Use the existing
> standalone archive layout with a checksum-verified release archive.
> Stop QEMU after the runtime prints the results.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   tests/functional/hexagon/meson.build     |  2 +
>   tests/functional/hexagon/test_packets.py | 47 ++++++++++++++++++++++++
>   2 files changed, 49 insertions(+)
>   create mode 100644 tests/functional/hexagon/test_packets.py


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


