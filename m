Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B26606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p8QkHDrO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GSgmGvjV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUFhR-0007se-7i; Thu, 19 Nov 2026 22:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhP-0007qz-Bj
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhN-0000TQ-Gy
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:07 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK3V08r052758
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LRakfH02LU75RZhUioCws4hI0ooMnIMoaiHk2Zu6Xfg=; b=p8QkHDrOovFKKXCR
 yDdzpEm2JGszUKTaEp7IYGUAM4TyqbmRrNuFppdlUf0oX2Ct78kmWPpe1u4EX33M
 jOCdCI3Nyeeh7dl7KbOFltDtZ8b2mBuilQm/C9i27QPikRr66vlZawrYlocDENII
 Fo8p/iOKKVxRXW6m2zpLJciNO6VRZ5MZ0YBR+dyF2RUwU02RQeSgQwRHNgreU39M
 Dzr5eJ8SOURbO1ytkwRjHM2N08ysptJs6TaffROufhHe+tm85dYVQUrpaABjJmlN
 Ou3bR+2KrCj/LHOf3gI6S47AOpFfmfkD0ARDxW42xaLj94xOt17LNQPHOMNdN9aD
 15hOgw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yx6c40d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:03 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b29df78132so514015c88.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 19:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795146843; x=1795751643; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LRakfH02LU75RZhUioCws4hI0ooMnIMoaiHk2Zu6Xfg=;
 b=GSgmGvjVawzqSjsZ1RtFDBkirE9QfwKlXLhohjCPeXKcJN+3xOVnEBuAnd2iuz7NcJ
 2o80YLAnlWBzLu0XROWOLfTvk1I5+W6tUeGZxnBabBiCo6RD6Dq7U+vSDq8hgcMCqwKk
 mOsIO7gSXjUTnrdacN9kTrvLr92+sP4/AFeD9dd0Hc2b6KuIhuzuMaHBZDPy5482AdcL
 +0EkNXcx3RK0VGLr7UuI0MTTCfRhGnNhIzhN5zSS15OKDxLWEoK5rve4Zumetg+tJtyN
 D5g7E84azemV05H3mWLfWCf+R9DS2mTBWbxgcGpnS+w8fGQAg/oNK4XT0kal9lacyP07
 jSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795146843; x=1795751643;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LRakfH02LU75RZhUioCws4hI0ooMnIMoaiHk2Zu6Xfg=;
 b=KLQeQweaN/Mw0Qf6XoBmr/SkXjw3NlB2dVWPoeQvikcEBzNT0AIaK7kHNqCOiEUmrF
 q/0f9sy4ijfcxdKXbFs7RLHXUPWXfTyTrY2EYrAXqK7vmoYYsjhiPlIfnu8QMPfDZvSG
 tY1gdNvGnrnUKPyB65cvxVsAa9U81ky6Apurq2XwNC7fYyJBrNfs6t5gHxFsYCFeS6k1
 b9tAJEGqPtDKtRa7GZdHlWgMmwDkn6C4adxsnPPwDTFeGaY5qObl7DB9Tl1hO8WvXs3p
 q1jBB0U6iKwmbjoyot8wy8Rc+pVxDcMiDwQXlMjKhB0WBBbhfjjJ/J8UNZLTNQfCcKmK
 sR+Q==
X-Gm-Message-State: APuU4Z/G+SAluENHwGPZkgBbcxiyB7+tn3xWfa3tsftanDRouHtnTj+V
 I3hDV+zmqIICOAtEtVE1Ix46Oq7mQhyrW5v/ZWt5Fti/32aaEg869kEaW1b7hSnlwKwdt1rSnW5
 /a5SWI78DBf5RlfcuQIAfszRqXBb8omp7Gq4Z6qEvwquOmo2PZpBkqDIlvApni71nDA==
X-Gm-Gg: AYBFou24u2dNABnXKDNXEy/60MdO/Ph9SLFnw75olTIzlmBCn+mXXUyRpgF6Jx8miVy
 L52glbYvqvGAIMA1VuvOSI88E9yd9NASUETumJM9C97LfLZwtnyrEC6HJmxu7XxLNwq28qwYvhQ
 /GBrU/K6gvh+Pd+F46S+gfi6IkWanP/iBbXI9b50gzzFY4/+OREsaUE85TUVYtgzifcgF71b4/A
 UZ0q9jtiCGZRfhjkMsHz+D331yNog4PAYW2CCI01VbwOdodS5GkTGiDacB5MmEHJsFAR9GnpO6s
 ghtO6AWGAokkRrTB9f3AxVU+MKcr/CCM+Seh3NMopMojd3eUoU2v9LfBuI7Ti5q8u68nnnWWyJ3
 DJ1OZKCA0td6UG4akohG8vIx/cZapZKEkNJNeSOmhYDmbjHj6kHh8invW/TyGAUce5JrfJA/KYF
 /1kh2P+kCqRm+NnFwjl1gi
X-Received: by 2002:a05:701b:450d:20b0:185:fd0c:4585 with SMTP id
 a92af1059eb24-1b558384c12mr1064779c88.33.1795146843235; 
 Thu, 19 Nov 2026 19:54:03 -0800 (PST)
X-Received: by 2002:a05:701b:450d:20b0:185:fd0c:4585 with SMTP id
 a92af1059eb24-1b558384c12mr1064750c88.33.1795146842501; 
 Thu, 19 Nov 2026 19:54:02 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm3854126eec.4.2026.11.19.19.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:54:01 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 3/8] target/hexagon: Explicitly pass GP to helpers
Date: Thu, 19 Nov 2026 19:53:48 -0800
Message-Id: <20261120035353.3215703-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
References: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Sjn1M5KFXTzgmOIx9POspoxyt-t-9sB1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX3lzIvm6CHiRv
 sJRQvG2sZzW5DvaJE9U8jdX3e2nBh9ML9LKZpSYRRZ1fTpnX5IuYKcfZ9ZyRCXgcwKVwHrC2CV4
 Dc6DBgdhum0tHxoxvKl+PqMz+RFMC/s=
X-Proofpoint-ORIG-GUID: Sjn1M5KFXTzgmOIx9POspoxyt-t-9sB1
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6affc45b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=7cD_sA1PiFyWv3eu00UA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfXxefb2I8bi6IU
 sy6r8+kZNR9Huw/YQvt7P4gWJpiHESsHcJ+5M+knL5xE1CIQDeKOPqiSpzyzZEIL2lLP1hWlJKr
 GbO4o1OC2XgUav1zsKWWkpjLUBeD5hcXiSlki3fLOyUZT3UPRMNqPOa1Wpf96u8PvKpTkZi9dvd
 TgYusjJv84SWBrOI98u1bG0nXyOzBmiAKta70mM6sNAXT8R2KM/prDQ8TzQSjsq0MZWgwrmo70X
 OPwgUGPkbYJ+eEia3y9hAqXknKtxohmQbeuYZj7QnqKs/OGGFzIE2Kl55ixgo6/ACxIfV0lntiF
 o/11b2cejEp5PFYBhfieRm7ZohR6+MD76JH17p1Zvlk3TqW2ivkWb/3J0uOZDIOSn+Ui8Z96ezy
 pSWhkB/z4omkSsVlfrYGFrjFVCjVG7bnXNPM/mZXAP+GuRe7vUXPSkIGetitgSgtNdSlUNILb5m
 NUHRyMxHB3WAIBB/X0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200015
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KCmhlbHBlcnMgdXNpbmcgZlJFQURf
R1AoKSBhcmUgYnJva2VuIGFuZCBkbyBub3QgYWNjb3VudCBmb3IgdGhlIHByZXNlbmNlCm9mIGV4
dGVuZGVycyB3aGljaCBjaGFuZ2UgdGhlIGFkZHJlc3NpbmcgbW9kZSBmcm9tIEdQLXJlbGF0aXZl
IHRvCmFic29sdXRlLiAgRXhwbGljaXRseSBwYXNzIEdQIHRvIGhlbHBlcnMgYW5kIGNoZWNrIGZv
ciBleHBhbmRlcnMgYXQgdGhlCmNhbGwtc2l0ZS4KClNpZ25lZC1vZmYtYnk6IEFudG9uIEpvaGFu
c3NvbiA8YW5qb0ByZXYubmc+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCAgICAgICAgICB8ICA4
ICstLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYyB8ICAxICsKIHRhcmdl
dC9oZXhhZ29uL2hleF9jb21tb24ucHkgICAgIHwgMTEgKysrKysrKysrKysKIDMgZmlsZXMgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21hY3Jvcy5oCmluZGV4IDI3NDhl
MjZkNmM0Li45MTg3YjAyZTZjOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgK
KysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTM0NywxMyArMzQ3LDcgQEAgc3RhdGlj
IGlubGluZSBUQ0d2IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQsIFRDR3YgdmFsLCBpbnQgc2hp
ZnQpCiAjZGVmaW5lIGZSRUFEX1NBMCAoZW52LT5ncHJbSEVYX1JFR19TQTBdKQogI2RlZmluZSBm
UkVBRF9TQTEgKGVudi0+Z3ByW0hFWF9SRUdfU0ExXSkKICNkZWZpbmUgZlJFQURfRlAoKSAoZW52
LT5ncHJbSEVYX1JFR19GUF0pCi0jaWZkZWYgRklYTUUKLS8qIEZpZ3VyZSBvdXQgaG93IHRvIGdl
dCBpbnNuLT5leHRlbnNpb25fdmFsaWQgdG8gaGVscGVyICovCi0jZGVmaW5lIGZSRUFEX0dQKCkg
XAotICAgIChpbnNuLT5leHRlbnNpb25fdmFsaWQgPyAwIDogZW52LT5ncHJbSEVYX1JFR19HUF0p
Ci0jZWxzZQotI2RlZmluZSBmUkVBRF9HUCgpIChlbnYtPmdwcltIRVhfUkVHX0dQXSkKLSNlbmRp
ZgorI2RlZmluZSBmUkVBRF9HUCgpIChHUCkKICNkZWZpbmUgZlJFQURfUEMoKSAoUEMpCiAKICNk
ZWZpbmUgZlJFQURfUDAoKSAoUDApCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9hdHRyaWJz
X2RlZi5oLmluYyBiL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCmluZGV4IDcxYzZm
MDQ5MTJhLi5iZWY3ZmY0NWQ5NCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vYXR0cmlic19k
ZWYuaC5pbmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMKQEAgLTEzMyw2
ICsxMzMsNyBAQCBERUZfQVRUUklCKElNUExJQ0lUX1dSSVRFU19MUiwgIldyaXRlcyB0aGUgbGlu
ayByZWdpc3RlciIsICIiLCAiVVJFRy5MUiIpCiBERUZfQVRUUklCKElNUExJQ0lUX1JFQURTX1BD
LCAiUmVhZHMgdGhlIHByb2dyYW0gY291bnRlciIsICJVUkVHLlBDIiwgIiIpCiBERUZfQVRUUklC
KElNUExJQ0lUX1dSSVRFU19TUCwgIldyaXRlcyB0aGUgc3RhY2sgcG9pbnRlciIsICIiLCAiVVJF
Ry5TUCIpCiBERUZfQVRUUklCKElNUExJQ0lUX1JFQURTX1NQLCAiUmVhZHMgdGhlIHN0YWNrIHBv
aW50ZXIiLCAiVVJFRy5TUCIsICIiKQorREVGX0FUVFJJQihJTVBMSUNJVF9SRUFEU19HUCwgIlJl
YWRzIHRoZSBnbG9iYWwgcG9pbnRlciIsICJVUkVHLkdQIiwgIiIpCiBERUZfQVRUUklCKElNUExJ
Q0lUX1dSSVRFU19GUCwgIldyaXRlcyB0aGUgZnJhbWUgcG9pbnRlciIsICIiLCAiVVJFRy5GUCIp
CiBERUZfQVRUUklCKElNUExJQ0lUX1dSSVRFU19MQzAsICJXcml0ZXMgbG9vcCBjb3VudCBmb3Ig
bG9vcCAwIiwgIiIsICJVUkVHLkxDMCIpCiBERUZfQVRUUklCKElNUExJQ0lUX1dSSVRFU19MQzEs
ICJXcml0ZXMgbG9vcCBjb3VudCBmb3IgbG9vcCAxIiwgIiIsICJVUkVHLkxDMSIpCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIvdGFyZ2V0L2hleGFnb24vaGV4X2Nv
bW1vbi5weQppbmRleCBmODVmMDYzZjUyZC4uMjRkY2RiNWNlMWMgMTAwNzU1Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eQpAQCAtMTQyLDYgKzE0Miw3IEBAIGRlZiBjYWxjdWxhdGVfYXR0cmlicygpOgogICAgIGFkZF9x
ZW11X21hY3JvX2F0dHJpYignZkxTQk5FVzFOT1QnLCAnQV9JTVBMSUNJVF9SRUFEU19QMScpCiAg
ICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCdmUkVBRF9QMycsICdBX0lNUExJQ0lUX1JFQURTX1Az
JykKICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoJ2ZSRUFEX1NQJywgJ0FfSU1QTElDSVRfUkVB
RFNfU1AnKQorICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYignZlJFQURfR1AnLCAnQV9JTVBMSUNJ
VF9SRUFEU19HUCcpCiAKICAgICAjIFJlY3Vyc2UgZG93biBtYWNyb3MsIGZpbmQgYXR0cmlidXRl
cyBmcm9tIHN1Yi1tYWNyb3MKICAgICBtYWNyb1ZhbHVlcyA9IGxpc3QobWFjcm9zLnZhbHVlcygp
KQpAQCAtMjQ2LDYgKzI0NywxMCBAQCBkZWYgbmVlZF9zcCh0YWcpOgogICAgIHJldHVybiAiQV9J
TVBMSUNJVF9SRUFEU19TUCIgaW4gYXR0cmliZGljdFt0YWddCiAKIAorZGVmIG5lZWRfZ3AodGFn
KToKKyAgICByZXR1cm4gIkFfSU1QTElDSVRfUkVBRFNfR1AiIGluIGF0dHJpYmRpY3RbdGFnXQor
CisKIGRlZiBpc19odnhfaW5zbih0YWcpOgogICAgIHJldHVybiAiQV9DVkkiIGluIGF0dHJpYmRp
Y3RbdGFnXQogCkBAIC0yMjEwLDYgKzIyMTUsMTIgQEAgZGVmIGhlbHBlcl9hcmdzKHRhZywgcmVn
cywgaW1tcyk6CiAgICAgICAgICAgICAiaGV4X2dwcltIRVhfUkVHX1NQXSIsCiAgICAgICAgICAg
ICAidWludDMyX3QgU1AiCiAgICAgICAgICkpCisgICAgaWYgbmVlZF9ncCh0YWcpOgorICAgICAg
ICBhcmdzLmFwcGVuZChIZWxwZXJBcmcoCisgICAgICAgICAgICAiaTMyIiwKKyAgICAgICAgICAg
ICJpbnNuLT5leHRlbnNpb25fdmFsaWQgPyB0Y2dfY29uc3RhbnRfdGwoMCkgOiBoZXhfZ3ByW0hF
WF9SRUdfR1BdIiwKKyAgICAgICAgICAgICJ1aW50MzJfdCBHUCIKKyAgICAgICAgKSkKICAgICBp
ZiBuZWVkX3Nsb3QodGFnKToKICAgICAgICAgYXJncy5hcHBlbmQoSGVscGVyQXJnKAogICAgICAg
ICAgICAgImkzMiIsCi0tIAoyLjM0LjEKCg==

