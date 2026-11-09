Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37640606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X/y3nD/E;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IHAd2Wo1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHqU-0004b5-C4; Mon, 09 Nov 2026 00:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHqT-0004ae-Ch
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:23:05 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHqR-0005X2-Hc
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:23:05 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93KMQB2746295
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 05:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kRVpOVow4p3r6dB1AyoFA+aNsokbBYDARw9lxkpj5Xg=; b=X/y3nD/EF2o4EioP
 DrhtiZsP9idV55wnCi0YCZvk6/QOkf9lfGqs88cu8JDra2TQTiBBgqnSYB8p2u43
 mEMiYAfC11Hb+GewJZMzhv6BDd4NfV2OHRyKd0WIibFJHzKDx+8zX57zY6wI0lDL
 At5quoT3QWFpwSxyzFtwiPtn5PYgloB0I98trYqS78bwFMkXJOFmJoW7+zSPLDSM
 KYxRSN8croi2Ut72vAtZY86j14iHxuyodDxDukDiAeX5d0azGtpPGpScBWZFOfsJ
 OjLKlb0neoAVpSj1oFR2uWos8cwRxpDKEVVlGqsPfub2lXfe5GxN37RqsiaA1CNK
 GYHWfQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvrevn83-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:23:01 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-37390b2989bso1815441eec.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 21:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794201781; x=1794806581; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kRVpOVow4p3r6dB1AyoFA+aNsokbBYDARw9lxkpj5Xg=;
 b=IHAd2Wo1jMyZnfCtgKKry703fb3u4Qw33+Fw44M9LW3au2nLM8GPwixcpc/ASX/k01
 XBS6M9EbkPruKQJiyD5Zj5SR4P7lNlzSQGjYEzxEX6uCKXT71mqU7rXG6k4ShPHJifRi
 4SuckcsPKN1J8uqQ+aZEqTo+lxn9G4USZyujx7+l36vtE17FjjJOP3xR5dfc7LWUHLtb
 jaZiMfWd+R31CFNS9zKoCjkc79tz1CAJ7+CUBilCUwOjy612s4tZ/XszuIkgyn3A8cYv
 Aep+syU7aEkKBDvdNoGAVxBR+Bq79BKtzgsdTa+ssiDLuPYGOfqXhH/tDQC1KL/ZEeDg
 VSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794201781; x=1794806581;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kRVpOVow4p3r6dB1AyoFA+aNsokbBYDARw9lxkpj5Xg=;
 b=pn8sTaLq4TwZgj22FEj7sOgdec2UhmM7feabycW5sfF+STFZrdsIE3vCfkIC2iXSgt
 CLfHpjEJs49lMZvhma6TaOa2FHutNIq2QP9/Ac5vgwNEY2sAF0LP5UVAWPdvAnXtQgEv
 ybHPPwKeUyRqCwl9b8Fe0aiWSeVaqQa3o07BYlsP/CcR7HpqdxKYIHHeJHM4YtpGIMUs
 95YqSBb3p2Hm7cBy6PgQz0e1nCwZ4YYoKL6Ye4MNNHJgRHoBqWEEKMHx67YjxOz1kowq
 212+Pfi8rZwPYmj9ZJsUBD2owxR8DlXDViqQMYtdnJexAW8FsXplWh13jaR57G45Gqge
 2WWA==
X-Forwarded-Encrypted: i=1;
 AL+hErGvoOjj4DnQKYkugL3A8CTs4nmEMfxXkc+z2J57vBmEA8cItdgcZ0J2RfkhQpvQgIVGu5HgtCAeIYvB@nongnu.org
X-Gm-Message-State: APuU4Z+uDGEXm38l6ep0529Ug/inlXqeD232Gs618m38cSYLufrYEN0L
 2LVK/8S1Ix6Ud8YFED6P43Xn+Di8mjiw9Akmwpym4jxL3gqPZ7G2ZqaJdiv2CCTORIsPFdPKoZm
 +QKyp4kBWYne9kxJ6EtkI+6iirKjontvNPOu+vxXLhbaW/zoVOm0cWMQIAw==
X-Gm-Gg: AYBFou021L1KzUE6Qeshvhmd1n9zU4MaWnvoPR0EA7StYBzMf5Jo1jUrEQuNqqCfxEK
 gbPk/KeKFguXaovYkqSNrNN9Nc2k8Jx1a2G2G5jDJ1zVS2MY11qQ6poDAX2dGki69Fv5Hyj92EO
 TkdVqI0+CINWQIyGGfTU2Ekt/wQnkmLoxpXCLU8Zy3N0FwXd73Tqvm6LZT18zPYfhX8zETWNDwC
 u8r9/ZVm9louR9K85QwkNdAXspRLxEOP+pZgA4pgv98NklVb5SKwSfSch1gs/P84j0We7hJ/O1h
 J4Mgz75yJlx4S3W7VML8TzN73BSVItagM8v12bQiITXro5UnSztaNMzclrdRxWXfssyirf16aff
 XtAP0FAK1QtB8KZTZkvYxatU3p65YR92ERpi29JDQXTkq3FKD6fo0NEDqSPUPzMpxShj41flaxN
 kj3WzqVPSwRewwXlxyksspKJSI0zz4FKf7Iqp288pWjw==
X-Received: by 2002:a05:7301:1285:b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-3725e33de65mr8381847eec.26.1794201781214; 
 Sun, 08 Nov 2026 21:23:01 -0800 (PST)
X-Received: by 2002:a05:7301:1285:b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-3725e33de65mr8381811eec.26.1794201780683; 
 Sun, 08 Nov 2026 21:23:00 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372660f444csm14920605eec.19.2026.11.08.21.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 21:23:00 -0800 (PST)
Message-ID: <abfae377-75f5-4020-adfb-630bcf320cf9@oss.qualcomm.com>
Date: Sun, 8 Nov 2026 21:22:59 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/hexagon: fix FDT address and size cells
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
References: <20261109050327.1475448-1-brian.cain@oss.qualcomm.com>
 <20261109050327.1475448-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261109050327.1475448-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfX+pW8OpZR8R6l
 wt0EZIrVv+4viD0Sotp/6O5t5i6xqPvKID715cuFd99oOYITUj5CNQdXY0X24DQU7P7wuQnj18v
 UQy8v5dRDd3uCJ0CyKQSLxX2qt/Bh1U=
X-Proofpoint-GUID: d6PF5bId44HPAHt5LYZmlrrVcN0KanLl
X-Authority-Analysis: v=2.4 cv=FrKQbGrq c=1 sm=1 tr=0 ts=6af158b5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=3qlB4M-CmNs9RCOw9W8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: d6PF5bId44HPAHt5LYZmlrrVcN0KanLl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfX5PIhUirC47r8
 ko6L3ARWjA2/ZMZQGdjMjpJ0AHuXGcnHfAfk53PBh+RZdIzOTfKHvU8/AN8ftGtg57yj2FRc2Z+
 wfgKnWpJJ/UnTgF/kcit3JORCvNVB9ZQDiqpmXKd1qImykDeryxHDy14/LGdPD5ZgqXIx6Hz7Zr
 nlmw7lgx0TbDLCMPkYo5eSsANLggtYMsmN9Zte7SQvkRF5824QgdqE+deDsMlyW1WW/wCXKCUqu
 QUQCs+eIY0p/sTa2VxZepfjV4KrHCLGkNHp7enMteXOyWxc/daDBN+kNaieJheFUzWz9XidspIO
 zZfbdQYVnHiOraYqVVcv2CNJPM6FQ/j8wt4zch7OWF48IaAml6+L6OBISV4llqH1ymRmz7DtZpq
 Yl0n75vyX5OBediKdiXg+dYoahV7CTJxKn/DdCHXfTFvfreLqARMf0H2FauEwae5LdOMRjWy9bt
 ZZc7tGLBrNZ0NOayoIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
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
> Hexagon MMUs support 64-bit physical addresses.  Describe the root and
> /soc buses with two address cells and two size cells so their child reg
> properties can represent the full address and size range.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hex-board.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

