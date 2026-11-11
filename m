Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD521606A887
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bY2Uhg8N;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LWPZ4LDR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRCoM-0004ue-EG; Wed, 11 Nov 2026 13:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xRCoK-0004sE-TD
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 13:12:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xRCoJ-0002YJ-1D
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 13:12:40 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHt9dG3989285
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 18:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u0FoAJVkuYosngBG6Rs6QE0oJU4UPQ8MdlY+xDm7aH8=; b=bY2Uhg8NZ3amXibL
 0k5jqUZPuWI2ghG7/akR+RIh7SuAui6brkB5dCuLnLXMABVLdtFCWzr1DKDwB7cp
 chBac+/tDi540MrD+8uCI9jv49H3LeB1mLIa6Tm1jPl2UICgXCX1RrYAnJbe+Agx
 eKjn+Aawqiv6VREFLLTkcDQsiWYmT9mda+Wabkg3LSfvMULD8xGT74LX8IWVluCb
 LQ4IaNzlPe4GjSj9hXstOqRz0PAfrDrysn6oa5TNppQ5rZCIDHEGaBevHK3UNIAb
 eLqpm7IpnO1y62ZCPKyehEeVxxZgB6UszpGM9SmZyaz9xOns2o6hx7av2o9uGlp8
 N0Vx3w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1u90m0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 18:12:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-37628596fc9so376952eec.0
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 10:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794420756; x=1795025556; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u0FoAJVkuYosngBG6Rs6QE0oJU4UPQ8MdlY+xDm7aH8=;
 b=LWPZ4LDRrNDBRUSqDwraWYpTh8SRfUvBe/DHPY29BQsVZYF0IycN1yRvATakkcjUVD
 zVOKrrdTSBx2z1fmxGsuXw54bI9s0M2weFEg/x1S7BQ29GSWTRSpLSJhrkmexCMheP5m
 FB9n1qkyy/nrT+7lGfw6b3Ffy1SlSHFI8oPz9d6xcgxA2gWV0MFeph24JElz5MUhDiqI
 kb6NM3YuEFgw9eL2i0MYnGOJu4/EedH11stFCeIzMlLOyeZu4ValXlqgBX0M20O9824G
 Fwoka3QctpNe3cwtxqWDpJONT9i6x+QNITLFR+TJRDoKfZxSpKqOaeQT4U3/FQsv9aR2
 5ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794420756; x=1795025556;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u0FoAJVkuYosngBG6Rs6QE0oJU4UPQ8MdlY+xDm7aH8=;
 b=ypnlo2H0U+FsajHovlZ31zDRggW8o8gGysA5aO5UXkBE1s5A4Zf1cmxDW2s4w0NOvL
 zBb6kdC78T48k/wqCzUdOMz6kJkzoDrBLuI5anFB0QlKSHDrH7KCUz0ymMrzZHz0UZps
 7ZpACN3fnZ0LLvMpsxKng+NeYKTPTtBOGg/v/sSbCNyxfooD7YzECfyzvXpA9Ra2O3uz
 Dd/veh0dPdjeUsdR+siKl9vqeXfVMMwK5EvGdrfVdKuCLjlBH+AVclWedeSkbgVIbHG0
 12tIBUgIqYY2ed3oJxC0JslwqeE7UFMWAVlbhe58QZdMxkZVhjcvH9Dck4KVpKf8kW0b
 QwGQ==
X-Gm-Message-State: APuU4Z8xw3cn5U/Xfh+vQoVSAhK1eqhrScsPTx0gJKEDp5SV1b8eqp4z
 SUYAs2pnTrk/1oJFgZM/4JUrD8LlmTUosGpIO02ioDykqV7OasZGBeNQ8adbDPaj9SAG01UCLQ3
 Uo9IIn8fmArCglIIxzOOEfPyCU9HeRHRXpEfMI/xVkaxkeS9OMjpgrJkU0NH9YcsCng==
X-Gm-Gg: AYBFou28Tvi9La7t/kq0wMB60La765MIF3k++/ws5m5iNg2CrIazjx6mLPhUfXiPRcD
 czTL7jdGhglaDL6NVILwZC162hm3EfW96EJkJ5FSm2yhcyblscENSXyLM111qAhr6gS9aduodab
 /bleaT93emK5hYwIOgUz0bKAcERdh3e8Moo2GPGHjO9Y8GX1KF3h+UinMSCGvhIfu5mYLoS+WG9
 GYFCvObT2Jo9qHYz8xSoidkd+RMnbS0NgnGqqo7AbW/HblpWGw/xgZ3XT6qCY+CrSNCRAJOHEHg
 NFxEl8E6y28wi6nRcX363nrB5T1lgj5iPYjNqHxNFEG3OR2/7opz7xv50KywSxi9Q9vk2SLzfh4
 4dePfHkP3RpiyNKVOTVwUn4Hv6hsTxGuXbuZenpTNdo7zu2zqfhw2cLbQenP6djzgwU4pRJjD2o
 +MyZF/K2MhE41WsIvkYLKEKCsppK9YYADXNKnsYStcwLs=
X-Received: by 2002:a05:7301:906:b0:35d:4185:5395 with SMTP id
 5a478bee46e88-37686171e97mr4143023eec.16.1794420756457; 
 Wed, 11 Nov 2026 10:12:36 -0800 (PST)
X-Received: by 2002:a05:7301:906:b0:35d:4185:5395 with SMTP id
 5a478bee46e88-37686171e97mr4142989eec.16.1794420755771; 
 Wed, 11 Nov 2026 10:12:35 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520bfb58dsm33313549eec.18.2026.11.11.10.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 10:12:35 -0800 (PST)
Message-ID: <7d4f82b3-3571-4945-a357-2d19130ede50@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 10:12:34 -0800
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfXxrwV/fPx0+Y0
 WfmvUSnG2mBFcNU7wXgQKoqXXkhkboOe//XasqZwne4yd0VriZuEFxfv5SzYoy37o695yjjjF8u
 Zb+V0tRhww3+sENX1JLrhLUmRtACi8E=
X-Proofpoint-GUID: U2mcwEgkMdbwWK0gdqk_yllbTnCGzgu_
X-Proofpoint-ORIG-GUID: U2mcwEgkMdbwWK0gdqk_yllbTnCGzgu_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX5eVkhJeiIGrY
 Lk7JljM9rME6mRElDYxbJzwwjQn9/ispSXvHf/IdhQjdQX6PM5jh1HBHaHvq7oFkqUkv3h9NiPm
 4UHDK5PDMipFXSBkXgWdX1P5KnB9FIuS01wGW/OQTZ7jrD9dHx+is7XWdY8MJsbpSSeaZdaKHWu
 Fey8siczOZSbjX6WCYf/jyLH9XLtiIjIceG1Qm3pyVy96Ds30zAhouMD/ipNcdQ/8FrFmYv2U8U
 nrqmBLQs97zDUfHOK7MigqjywXjbVwdpkc63mCmmdoZ8cCK3sPa+nyJPCl50fvqayiO87qWrO2V
 tJUScw1Hne1b/Pb+aQ0kiTho/xcEHPE2Sq+EpuKyng+NHWNaitAS62l39d50LJkETher5bnMTOt
 /iMKvtN7tsqJkv1ZqkaQRrUI0FuzzypF2WuaxTwlz/Hi2yixbx0Jc9NnXxyYRnJxonGBZNcnX2t
 2X6lII2+Ga4QuuWJ3DA==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af4b015 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8 a=lDtavSEJtHVKaDUYZlkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110072
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

Ping on this v2, would it make sense to include this fix for 11.2?

Regards,
Pierrick

