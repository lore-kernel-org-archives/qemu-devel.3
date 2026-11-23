Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AE606A336
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gv5mm6E5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PkxHRuNc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXFd-0001pO-Hn; Mon, 23 Nov 2026 11:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVXFb-0001p9-DY
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:50:43 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVXFZ-0006dY-GQ
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:50:43 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGu9t2486557
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 16:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0ivxeWXPkrHb0z9KsFdlxHw+mlSVVhR/S7HOz0QGE8w=; b=gv5mm6E5OjbaFwz+
 RDWxF6N/g7R3igwVnIdevv8dILgcocviJZPt2pdU7I8CHL5sqYA5gvin1ARksMfn
 I9sA+rBgRW6UnTiszpHCC6B1bZ1huJ1wCjV6ztrNY6SWJKhu9JTxmRQTnWRFwudY
 pJDkY6DKXCZu0JNKdJuZgvK0L+e6W2Q25aQpQGYQzcQZk0DPCsiJ2m87I7FhwVQD
 n8FucwZf75hQfayeyCtByioGZTM8nTbc+EZQQPAh3ZY02hQ4oZj2YjrCgerwrT7O
 bFZ92ykehyCaM9Mu/Lto+/tOtN7JuCPkR4fNzdsDUbwmoCV8m7FFAugcVHz7ZqCU
 KKXKpg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy02f1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 16:50:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-89f84753b43so2618466b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 08:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795452637; x=1796057437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0ivxeWXPkrHb0z9KsFdlxHw+mlSVVhR/S7HOz0QGE8w=;
 b=PkxHRuNcoYSYuqLl1Ub/fv6uN1zyb4WqqqTTjMA4iGw84NM7glwcEZJ4/cOTP0Ku4w
 D+Z0gFk4ihHvHBPiHfjeHEdKu+vQgGKAw02IJ1DnK2SeFO+dNXjgmMSBVFtPnQInMKWH
 2Jn5l2TAdgakUqVMQZIuHCjrGhqfjsRegBS9X8ngIzxE7NNhShOKCBpCFY19VuNijrik
 db9z3eiMOi2GUEqvNLbPqZ6JrKY9hCIj8tStQM8yS3c2w4Wx9e6WEyK7+YxFbfCLU9mk
 77O3ueNTnxbJJGYTtyyVuZvCROLSzbH+Vw2L6RBAJdxwRNCWegJAhQGK5OnEJz8MrnOk
 0yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795452637; x=1796057437;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0ivxeWXPkrHb0z9KsFdlxHw+mlSVVhR/S7HOz0QGE8w=;
 b=I/GY1EsEB4DeXjXnM68lvgfY2h6BJvNE/XGqAlBykLVJOosOs1rxGGnw8hZC1ApL+8
 4ZzXcUde6kj1CwV/rkhsV1fWS+6C6bVNtfDMY1KdJOiNPYYBEVMsfH+otkbIO1BCubNS
 E00U/pkrPv8CXvHUCtCTWkrI92TAJR4VIWUpw6xK5IbRwSX2A+uIuJVsRM6fVQwsmf6v
 9+t7S2NJyHG2Lry8zNbddXynfUZOEI42gyBD3lyl4+Ytd0U6MKH+6Tiz5KOARyJ/XZpk
 UaFAZ1VgXTENXp26duXLGlkzAJbnPw4tAa/GRgwGRyF6yVH/G06LiWXeAyllFISx4bln
 F7cQ==
X-Gm-Message-State: APuU4Z/KiOuzDLRdAKXmHozA+WWCraFvWGCFa0tuva7CNMuAUNWY6RkA
 fotajrRr2SOGzigVRf2vAMCrbwFRXNcuA1aKJt3sK8ilRWjP/x4lvYS0PmKTal7Q8bMqhdKDr6v
 8uLsaEWeAyhtg1oWBYT3QOxCtR3wNEvccUvydGs/uuzS5Fe3OenKiF6WrWLlGuDfAJw==
X-Gm-Gg: AZFdTZfverMB8iAjyQaZxfI6GyE6QRvPbtxz0vxdcim1XYrYfV8Xj95Obkw2A52LAnC
 mJaCDNw22W7IykaU/EjVYIXdAgEb7lTX4YlEqB7K5VnPWJRqyD++ocHYIT43YzXlzwYYyDQpfh8
 6HpO+KSzRIm7QLzzNSq0j9iScu3In7MAO+jy+RM7nN7B47LJL3KpW6wY2rdxVfQ4DqXby0ZNcc/
 h/YwckokxhqfHwrvT7N5cEBKn2UPGGWTIfKqnkG2rkCjgij8RuSctjNbr3jx+nXwX4FmytOHTst
 BiKtzjKyQ3emPLLhtckxduAynolPdm+Lk32QKGKyAZhtaSoctHkS7ReVDCK0PDhd/msNyp8PIWU
 rGioqL2wtPjsqcNo+nfXFKdI5SPfKy+WmAEuQ/BZXmDBUREG1sRNc2yZok1jBNcXSiLtbBCzpt7
 ZJd8s1yid3G6+0NlUtzHmtLpoYgLWFcUR7ajgN504h6i0=
X-Received: by 2002:a05:6a00:10cf:b0:87d:dc3c:1b5e with SMTP id
 d2e1a72fcca58-8c87c29067emr10087083b3a.26.1795452636549; 
 Mon, 23 Nov 2026 08:50:36 -0800 (PST)
X-Received: by 2002:a05:6a00:10cf:b0:87d:dc3c:1b5e with SMTP id
 d2e1a72fcca58-8c87c29067emr10087054b3a.26.1795452636010; 
 Mon, 23 Nov 2026 08:50:36 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87343f83dsm5906834b3a.39.2026.11.23.08.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 08:50:35 -0800 (PST)
Message-ID: <8528bc6a-2068-4d52-b736-ae3cddb51283@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 08:50:34 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gdbstub: reset supported features on Supported request
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 brian.cain@oss.qualcomm.com, Justin Sapp <jsapp@qti.qualcomm.com>
References: <20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NiBTYWx0ZWRfX3Qcif/VMcT5E
 cyHIfw/UI4j8Gku3fBL9J7h5E/Sn5zr9xq5s8Sm74DJM0N05yPmc2v9p1x2Tbd188o/CkruG4CO
 DStNL69KOxFJ/yD9MrwsX3lV16hUw88HyW7RkX9lfOLrMglQe9xY7zYlEb/i/UBvZIV4xicJ2J/
 7iUpuyF3C5aL71Q9kp/B4eSMofRcYrLUF+aOWiG/RdcM3cSuW53s/F6Z1rz6E6FwajBEdoFCIt7
 vA+nb7aG9EU6aMIWDDGcTlrD5WfUo4H3HXRQX87vklZk9vx028a1v5d4Zjjj8/WqGCacIOhaLmO
 1lcFXqnWl2kDCAU55FAQecoqdI/gocJZVSo6jABhsByrZaybUgD7BNCCFER22bTZpvUubHBxoLv
 mwafVP/w3unH7oz7BXdGoquqyCizKLAWnsd3ie5TYpUh3Dw94rVNmOP8KCxJx1/UthG1wu3ht5z
 PP7ERUJRFhdphXViPxg==
X-Proofpoint-ORIG-GUID: UC4Qk_OLi9usz83Q14HR302P7S2J44Bh
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b046edd cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8 a=lDtavSEJtHVKaDUYZlkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-GUID: UC4Qk_OLi9usz83Q14HR302P7S2J44Bh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NiBTYWx0ZWRfX8hUjnSdcBc9P
 mtWxjkHJp6NvO2aBKjP4NqBnyl1J8zYQqiu1cRdEwulaVEYHBa9zF8SNIUxl4EvQ2cjRtFbC8yk
 TzvqHbXgp8EIiM53SfWcy/N2TisvpPc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230066
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

On 11/4/2026 11:53 PM, Pierrick Bouvier wrote:
> From: Justin Sapp <jsapp@qti.qualcomm.com>
> 
> https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qSupported
> ```
> Whenever the stub receives a ‘qSupported’ request, the supplied set
> of GDB features should override any previous request. This allows GDB to
> put the stub in a known state, even if the stub had previously been
> communicating with a different version of GDB.
> ```
> 
> We exposed this by connecting to gdbstub using a gdb client first, and
> then WinDbg (EXDI) for windows kernel debugging. Since they both
> differ in their multiprocess support, this was confusing EXDI.
> 
> While we are here, fix the same for fork_events in user mode.
> Simplify control flow to always call gdb_handle_query_supported_user.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  gdbstub/gdbstub.c | 15 +++++++--------
>  gdbstub/user.c    |  4 +---
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 

Ping for queuing this for 11.2.

Regards,
Pierrick

