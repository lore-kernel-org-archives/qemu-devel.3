Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03D606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JZZXIzxT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f/Oaw9gw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT5WN-0006r2-4M; Mon, 16 Nov 2026 17:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT5WM-0006qt-8l
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:49:54 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT5WK-0006ii-RJ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:49:54 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfUUU3505592
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CZDeRr5natcJNjQwed7g+lrPl+MOxGxSaf3MU3+DVVE=; b=JZZXIzxTQDrvdMri
 iEE+HDa1Uyg/7xH1U6gVKZJkAXoVzNVDintY0J7mndMYr7IYHLwPOHWBSkE8hVj5
 mk/8YEYljIcYW9k9fNprhvvJbd4v3r3hFjtObOIYrm6jaHoEjETpF0pnK3+MtXhp
 k9bHZrLH8ygSWlW1jHRpKjS0zM7OV4sIJrzBvz+2Vu3em722JREBCvdu0+mR774p
 Ps/1hWaqa1kU5XOQ/2OOjO24KJKX599R3TOlw3yLuaRD++kl+Pm0YI12pABMS9q6
 UGbpw/aXEYIVmQqddDaqI/HR1oJJZMTDTZcWaVk3M5Cm9/iqDUc1WOkfJ3QfmBmY
 hyJTAA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j038ma0cr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:49:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94961ed97d6so65501185a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794869390; x=1795474190; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CZDeRr5natcJNjQwed7g+lrPl+MOxGxSaf3MU3+DVVE=;
 b=f/Oaw9gwC8CT/IrrC59Mbwt8btdDYTaiyHotLnIsELPo3p0UUP2H0WujbF5CT++S55
 QV4Xasmc4Uvoojaphz0KuI2cnR/BXducTjFi3Gp4eiEfYo3BUrcfEz45W8cm+1iusoAV
 b8nS5lkF2/ybMDOF03qmfMcOwcSzNLQN+LOAhlKoONwoV+4TVq7185zOo49t5mVLG8mb
 X5Bt7hDzzogByuQZtL0Qgl5wdVD2hgtqOt2LlsSwnJa/pfHNSRj0TCgFUorv7jC7sB4N
 ofjgXS0YVWCaNc+EkCuuaILqsTFF2gMwsnhhSxKFkebgR9wLyyp5hUbAel9vjWqWYj2s
 gSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794869390; x=1795474190;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CZDeRr5natcJNjQwed7g+lrPl+MOxGxSaf3MU3+DVVE=;
 b=hWHuZBYyqlo5ySyyJnPiOD4ssDwAgj1UZjRJNNrcVqq8Y2TcoOoqOBJCb6dTlDNIgi
 H0kprd5MG6Z40/KzbvKT7wy4ElMuuetSN5HkvBQXQdabjPj1sraYmlTkYyAxBRMJTCd2
 DCaRmSlmK+QvdKBUl7jSySYzXXT+EyURAz5WeOPn3jQphE4UGEiICZmAv/ZWe6Yicj1L
 v6SeuRc2mgs//QAX/9bD6M4QlwTowXF3aI+GGdl9LBbTaT9FKnKcTRNuhM1H7z82NvhT
 hjNmUXACeoJb69v77gDgJPS0/gaFTqRyyqAK59UtnVaHpHnX7jWOAfzW7jG0I4gfiu09
 2B5g==
X-Gm-Message-State: APuU4Z8bNZLRLngUphZ6Mo2Yg5HA1/MlDENlmxyitf06LHFVj4J1hGBk
 emSQ1tEquRbPDT7cXcwB5c64tA6cVv/ICmPY5Bt5aHiBQB/FwstiVCkKfhCKGGlK5o9LFN4tLrW
 1wlGZ4hmUMqVD61qf+c07ZueyWQ6HB10d4taK59CreVdqRdHli6Es9BKaiMkKiCTEag==
X-Gm-Gg: AYBFou01HnfhjEG5AJHuzUFa7QOiomYRBWpgsaoCORFbhSfqx6lzBSRyOj8xM+mHt7a
 Q2S7Tfikc/HDoQdQ6SnFwtOIisaiMeoQQ9puUkS27vGEGDal1rtYEhbTRG6jP0V882dCx4QWAC2
 a6OoN+Ox6rUfS9G51I7NylIWrNBNigW0z3PsfRlKgULyZ/z3Eb+EKYAm0nOzUJ9i1veFNzkqAia
 LirWuTZ5aCtZmLwi2WlHhmQYRCmEe3gyRNxNpcwfvJbQhBCByTtkcy5wYtYgeD7M6VHYmbVR1fZ
 DL6nFgxjX9LHW5C6tNfnxivAGCXMN1Z/5l/GjPTGB3OKtVgX9hr1wVxqiE/Ap0evprcf1+tszrc
 1pUcPsJo5GiDU1nJUCRscWqNVzA6HiJrd6ApTpJ3pppAo1p2ndVsMkvKaXpCtr94xHkgD+GQ0ni
 T2MfJdkF8=
X-Received: by 2002:a05:620a:8394:b0:949:2fca:4a82 with SMTP id
 af79cd13be357-9498b95853dmr144542385a.32.1794869389867; 
 Mon, 16 Nov 2026 14:49:49 -0800 (PST)
X-Received: by 2002:a05:620a:8394:b0:949:2fca:4a82 with SMTP id
 af79cd13be357-9498b95853dmr144539485a.32.1794869389472; 
 Mon, 16 Nov 2026 14:49:49 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7840b05bsm30807575e9.7.2026.11.16.14.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 14:49:48 -0800 (PST)
Message-ID: <7c7de3d1-2975-4b0f-af39-ff6ed5a4e94f@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 23:49:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: fix uname() return value check in guest-get-osinfo
Content-Language: en-US
To: Brad Smith <brad@comstyle.com>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org
References: <auUjFweAHtj1YSFt@humpty.home.comstyle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <auUjFweAHtj1YSFt@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MCBTYWx0ZWRfXwgC7mmj0en3h
 Uq7aaums1TWK48OTmMy1J4lx/He6yYr2CFXDdnJJiQp46txFWlNmSPCA7TtUP19YsI5GDEktSIk
 5NrleWBXlWaRrY4BCZe9o455JM5NKVoSAoFVMq70oCC5uwwiVCeWQiPj0o0ia0TUnCPM8VtPFap
 DKf8zVRsatJeuu1W+yPIm16ucwPnSk7z71TGs6cR2MUzKZmtCKPJr0h/oYqtQvTtOo8DQk4/GS+
 /LmOwvqimgONkECfBMPEuOIJO4WXaDxUp+cUgGRYLiGQmAbuG4eHEiJeUamO0tYUOyjGzelj7e/
 S7++sle2KTCUY1sSv/s2RV5YwWY1zq8wyW9WmY6/jdYMFT726JItRWpJtod3yPiCG0+6smTS2pE
 2zzrJAw/UtuJ2bi2ZrOztN5p7yZjtPsz2ZCstqexi8jtQ5/wYhkqjL9ftVhkzkhBnc5xl3y+Lkn
 aiRI2/pOnePDvBO7cNQ==
X-Authority-Analysis: v=2.4 cv=TckDJhQh c=1 sm=1 tr=0 ts=6afb888e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=x4Tn9eRuAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=NBNoG_gAMsMl4eXmfJ8P:22
X-Proofpoint-ORIG-GUID: OdLK5gkjwUJ6rfQ_f7FvnzG6kQWDInvH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MCBTYWx0ZWRfX9skWumlAwSYb
 OVMbCk/L4XYpyD3uf6iCWLk7egY5gi5ZI7sz4Xq4MZyAPhFGmMM09hSr0OoZMZoHf/boDeko9Ev
 2E3qztfldDT57Mprp7PNy+iGoxFJTyY=
X-Proofpoint-GUID: OdLK5gkjwUJ6rfQ_f7FvnzG6kQWDInvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160090
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

On 31/10/26 00:07, Brad Smith wrote:
> qga: fix uname() return value check in guest-get-osinfo
> 
> POSIX only specifies that uname() returns a non-negative value on
> success. Solaris returns 1, so guest-get-osinfo treated every
> successful call as a failure and reported a stale errno.
> 
> Check for a negative return value instead, as linux-user/uname.c
> already does.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>   qga/commands-posix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

